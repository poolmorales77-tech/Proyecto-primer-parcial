<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String usuarioIdStr = request.getParameter("usuarioId");
String nuevaClave = request.getParameter("nuevaClave");
String nuevaClaveConfirm = request.getParameter("nuevaClaveConfirm");
String adminNombre = request.getParameter("adminNombre");
String adminRol = request.getParameter("adminRol");

int usuarioId = Integer.parseInt(usuarioIdStr);
boolean exitoso = false;
String mensaje = "";
String usuarioNombre = "";

// Verificar que sea admin
if (!adminRol.equals("admin")) {
    mensaje = "No tienes permisos para realizar esta acción";
} else if (!nuevaClave.equals(nuevaClaveConfirm)) {
    mensaje = "Las contraseñas no coinciden";
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
        
        // Obtener nombre del usuario
        String sqlNombre = "SELECT nombre FROM usuarios WHERE id=?";
        ps = con.prepareStatement(sqlNombre);
        ps.setInt(1, usuarioId);
        rs = ps.executeQuery();
        if (rs.next()) {
            usuarioNombre = rs.getString("nombre");
        }
        rs.close();
        ps.close();
        
        // Actualizar contraseña
        String sqlUpdate = "UPDATE usuarios SET clave=? WHERE id=?";
        ps = con.prepareStatement(sqlUpdate);
        ps.setString(1, nuevaClave);
        ps.setInt(2, usuarioId);
        int resultado = ps.executeUpdate();
        
        if (resultado > 0) {
            exitoso = true;
            mensaje = "Contraseña actualizada correctamente para " + usuarioNombre;
        } else {
            mensaje = "No se encontró el usuario";
        }
        
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
<title>Cambiar Contraseña - Admin</title>
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
        <a href="dashboard_admin.jsp?nombre=<%= java.net.URLEncoder.encode(adminNombre, "UTF-8") %>&rol=<%= adminRol %>" class="btn">Volver al Dashboard</a>
    <% } else { %>
        <div class="message error">
            <%= mensaje %>
        </div>
        <a href="dashboard_admin.jsp?nombre=<%= java.net.URLEncoder.encode(adminNombre, "UTF-8") %>&rol=<%= adminRol %>" class="btn">Volver al Dashboard</a>
    <% } %>
</div>

</body>
</html>
