<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String nombre = request.getParameter("nombre");
String rol = request.getParameter("rol");
String email = "";
int usuarioId = 0;

if (nombre == null || nombre.isEmpty()) {
    response.sendRedirect("login.jsp");
    return;
}

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
    
    // Obtener ID y email del usuario
    String sql = "SELECT id, email FROM usuarios WHERE nombre=?";
    ps = con.prepareStatement(sql);
    ps.setString(1, nombre);
    rs = ps.executeQuery();
    if (rs.next()) {
        usuarioId = rs.getInt("id");
        email = rs.getString("email");
    }
    rs.close();
    ps.close();
} catch(Exception e) {
    out.println("Error: " + e);
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard Usuario - Provincias Ecuador</title>
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
        padding: 20px;
    }
    
    .container {
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .header {
        background: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .header h1 {
        color: #667eea;
    }
    
    .header .user-info {
        text-align: right;
    }
    
    .header .user-info p {
        color: #666;
        margin: 5px 0;
    }
    
    .logout-btn {
        background: #e74c3c;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        margin-top: 10px;
        font-weight: bold;
        transition: background 0.3s;
    }
    
    .logout-btn:hover {
        background: #c0392b;
    }
    
    .content {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
        margin-top: 20px;
    }
    
    .card {
        background: white;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .card h2 {
        color: #667eea;
        margin-bottom: 20px;
        border-bottom: 2px solid #667eea;
        padding-bottom: 10px;
    }
    
    .info-group {
        margin-bottom: 15px;
    }
    
    .info-group label {
        color: #666;
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }
    
    .info-group p {
        color: #333;
        padding: 10px;
        background: #f5f5f5;
        border-radius: 5px;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    .form-group label {
        color: #666;
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }
    
    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
    }
    
    .form-group input:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
    }
    
    .btn {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        transition: transform 0.2s;
    }
    
    .btn:hover {
        transform: scale(1.05);
    }
    
    .scores-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .scores-table th {
        background: #667eea;
        color: white;
        padding: 12px;
        text-align: left;
    }
    
    .scores-table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
    }
    
    .scores-table tr:nth-child(even) {
        background: #f9f9f9;
    }
    
    .scores-table tr:hover {
        background: #f0f0f0;
    }
    
    .no-scores {
        color: #999;
        text-align: center;
        padding: 20px;
    }
    
    .success {
        background: #d4edda;
        color: #155724;
        padding: 12px;
        border-radius: 5px;
        margin-bottom: 15px;
    }
    
    .error {
        background: #f8d7da;
        color: #721c24;
        padding: 12px;
        border-radius: 5px;
        margin-bottom: 15px;
    }
    
    .full-width {
        grid-column: 1 / -1;
    }
</style>
</head>
<body>

<div class="container">
    
    <div class="header">
        <div>
            <h1>Dashboard Usuario</h1>
            <p>Bienvenido a Provincias Ecuador</p>
        </div>
        <div class="user-info">
            <p><strong>Hola, <%= nombre %>!</strong></p>
            <p>Rol: <strong><%= rol %></strong></p>

            <a href="index.html" class="logout-btn">Cerrar Sesión</a>
            <a href="index.html" class="back-home">← Volver al inicio</a>
        </div>
    </div>
    
    <div class="content">
        
        <!-- Card: Información Personal -->
        <div class="card">
            <h2>Información Personal</h2>
            <div class="info-group">
                <label>Nombre</label>
                <p><%= nombre %></p>
            </div>
            <div class="info-group">
                <label>Correo</label>
                <p><%= email %></p>
            </div>
            <div class="info-group">
                <label>Rol</label>
                <p><%= rol %></p>
            </div>
        </div>
        
        <!-- Card: Cambiar Contraseña -->
        <div class="card">
            <h2>Cambiar Contraseña</h2>
            <form action="cambiar_clave_usuario.jsp" method="post">
                <input type="hidden" name="usuarioId" value="<%= usuarioId %>">
                <input type="hidden" name="nombre" value="<%= nombre %>">
                <input type="hidden" name="rol" value="<%= rol %>">
                
                <div class="form-group">
                    <label>Contraseña Actual</label>
                    <input type="password" name="claveActual" placeholder="Ingresa tu contraseña actual" required>
                </div>
                
                <div class="form-group">
                    <label>Nueva Contraseña</label>
                    <input type="password" name="claveNueva" placeholder="Ingresa tu nueva contraseña" required>
                </div>
                
                <div class="form-group">
                    <label>Confirmar Nueva Contraseña</label>
                    <input type="password" name="claveNuevaConfirm" placeholder="Confirma tu nueva contraseña" required>
                </div>
                
                <button type="submit" class="btn">Cambiar Contraseña</button>
            </form>
        </div>
        
        <!-- Card: Mis Puntuaciones -->
        <div class="card full-width">
            <h2>Mis Puntuaciones</h2>
            <table class="scores-table">
                <thead>
                    <tr>
                        <th>Puntuación</th>
                        <th>Descripción</th>
                        <th>Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        String sqlScores = "SELECT puntuacion, descripcion, fecha FROM puntuaciones WHERE usuario_id=? ORDER BY fecha DESC";
                        ps = con.prepareStatement(sqlScores);
                        ps.setInt(1, usuarioId);
                        rs = ps.executeQuery();
                        
                        boolean tienePuntuaciones = false;
                        while(rs.next()) {
                            tienePuntuaciones = true;
                            int puntuacion = rs.getInt("puntuacion");
                            String descripcion = rs.getString("descripcion");
                            Timestamp fecha = rs.getTimestamp("fecha");
                    %>
                        <tr>
                            <td><strong><%= puntuacion %></strong></td>
                            <td><%= (descripcion != null ? descripcion : "Sin descripción") %></td>
                            <td><%= fecha %></td>
                        </tr>
                    <%
                        }
                        if (!tienePuntuaciones) {
                    %>
                        <tr>
                            <td colspan="3" class="no-scores">No tienes puntuaciones aún. ¡Sigue navegando las provincias!</td>
                        </tr>
                    <%
                        }
                        rs.close();
                        ps.close();
                    } catch(Exception e) {
                        out.println("<tr><td colspan='3' class='error'>Error al cargar puntuaciones: " + e.getMessage() + "</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>
        
    </div>
    
</div>

<%
if (con != null) try { con.close(); } catch(Exception e) {}
%>

</body>
</html>
