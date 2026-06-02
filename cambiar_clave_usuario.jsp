<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String usuarioIdStr = request.getParameter("usuarioId");
String claveActual = request.getParameter("claveActual");
String claveNueva = request.getParameter("claveNueva");
String claveNuevaConfirm = request.getParameter("claveNuevaConfirm");
String nombre = request.getParameter("nombre");
String rol = request.getParameter("rol");

int usuarioId = Integer.parseInt(usuarioIdStr);
boolean exitoso = false;
String mensaje = "";

// Validaciones
if (!claveNueva.equals(claveNuevaConfirm)) {
    mensaje = "Las nuevas contraseñas no coinciden";
} else {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/proyecto",
            "postgres",
            "1234"
        );
        
        // Verificar que la contraseña actual sea correcta
        String sqlVerify = "SELECT id FROM usuarios WHERE id=? AND clave=?";
        ps = con.prepareStatement(sqlVerify);
        ps.setInt(1, usuarioId);
        ps.setString(2, claveActual);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            // Contraseña actual correcta, actualizar
            rs.close();
            ps.close();
            
            String sqlUpdate = "UPDATE usuarios SET clave=? WHERE id=?";
            ps = con.prepareStatement(sqlUpdate);
            ps.setString(1, claveNueva);
            ps.setInt(2, usuarioId);
            ps.executeUpdate();
            
            exitoso = true;
            mensaje = "Contraseña actualizada correctamente";
        } else {
            mensaje = "La contraseña actual es incorrecta";
        }
        
        rs.close();
        ps.close();
    } catch(Exception e) {
        mensaje = "Error en la base de datos: " + e.getMessage();
    } finally {
        if (con != null) try { con.close(); } catch(Exception e) {}
    }
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cambiar Contraseña</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }
    
    .container {
        background: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        max-width: 400px;
        width: 100%;
        text-align: center;
    }
    
    .container h2 {
        color: #333;
        margin-bottom: 10px;
    }
    
    .message {
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
        font-weight: bold;
    }
    
    .success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .error {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .btn {
        display: inline-block;
        padding: 10px 30px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        margin-top: 20px;
        transition: transform 0.2s;
    }
    
    .btn:hover {
        transform: scale(1.05);
    }
</style>
</head>
<body>

<div class="container">
    <h2>Cambiar Contraseña</h2>
    
    <% if (exitoso) { %>
        <div class="message success">
            <%= mensaje %>
        </div>
        <p>Tu contraseña ha sido cambiada exitosamente.</p>
        <a href="dashboard_usuario.jsp?nombre=<%= java.net.URLEncoder.encode(nombre, "UTF-8") %>&rol=<%= rol %>" class="btn">Volver al Dashboard</a>
    <% } else { %>
        <div class="message error">
            <%= mensaje %>
        </div>
        <a href="dashboard_usuario.jsp?nombre=<%= java.net.URLEncoder.encode(nombre, "UTF-8") %>&rol=<%= rol %>" class="btn">Volver al Dashboard</a>
    <% } %>
</div>

</body>
</html>
