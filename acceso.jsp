<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String email = request.getParameter("txtEmail");
String clave = request.getParameter("txtClave");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean loginExitoso = false;
String nombre = "";
String rol = "";
int usuarioId = 0;

try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/proyecto",
        "postgres",
        "1234"
    );
    String sql = "SELECT id, nombre, rol FROM usuarios WHERE email=? AND clave=?";
    ps = con.prepareStatement(sql);
    ps.setString(1, email);
    ps.setString(2, clave);
    rs = ps.executeQuery();
    if (rs.next()) {
      loginExitoso = true;
      usuarioId = rs.getInt("id");
      nombre = rs.getString("nombre");
      rol = rs.getString("rol");
      if (rol.equals("admin")) {
        response.sendRedirect("dashboard_admin.jsp?nombre=" + java.net.URLEncoder.encode(nombre, "UTF-8") + "&rol=" + rol);
        return;
      }
      // Para usuarios normales, guardamos el nombre y el id en localStorage y redirigimos al mapa
    }
} catch(Exception e) {
    out.println("Error: " + e);
} finally {
    if (rs != null) try { rs.close(); } catch(Exception e) {}
    if (ps != null) try { ps.close(); } catch(Exception e) {}
    if (con != null) try { con.close(); } catch(Exception e) {}
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Acceso - Provincias Ecuador</title>
<link rel="stylesheet" href="css/estilos.css">
<style>
  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    font-family: Arial, sans-serif;
  }
  
  .login-card {
    background: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 400px;
    text-align: center;
  }
  
  .login-card h2 {
    color: #333;
    margin-bottom: 15px;
  }
  
  .login-card p {
    color: #666;
    margin-bottom: 15px;
    font-size: 14px;
  }
  
  .success {
    color: #27ae60;
  }
  
  .error {
    color: #e74c3c;
  }
  
  .back-home {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 20px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    transition: transform 0.2s;
  }
  
  .back-home:hover {
    transform: scale(1.05);
  }
</style>
</head>
<body>
<div class="login-container">
  <div class="login-card">
    <% if (loginExitoso) { %>
      <h2 class="success">¡Bienvenido, <%= nombre %>!</h2>
      <p>Has iniciado sesión correctamente.</p>
      <p><strong>Rol:</strong> <%= rol %></p>
      <% if (!rol.equals("admin")) { %>
        <p>Serás redirigido al mapa para seguir sumando puntaje.</p>
        <script>
          var nombreLogin = '<%= nombre.replace("'", "\\'") %>';
          var nombreAnterior = localStorage.getItem('nombreUsuario');
          localStorage.setItem('nombreUsuario', nombreLogin);
          localStorage.setItem('usuarioId', '<%= usuarioId %>');
          localStorage.setItem('rolUsuario', '<%= rol %>');
          if (!localStorage.getItem('puntajeUsuario') || nombreAnterior !== nombreLogin) {
            localStorage.setItem('puntajeUsuario', '0');
          }
          setTimeout(function() {
            window.location.href = 'index.html';
          }, 1200);
        </script>
        <a href="index.html" class="back-home">Ir al mapa ahora</a>
      <% } else { %>
        <a href="dashboard_admin.jsp?nombre=<%= java.net.URLEncoder.encode(nombre, "UTF-8") %>&rol=<%= rol %>" class="back-home">Ir al panel</a>
      <% } %>
    <% } else { %>
      <h2 class="error">Error de acceso</h2>
      <p>Correo o contraseña incorrectos.</p>
      <a href="login.jsp" class="back-home">Intentar de nuevo</a>
    <% } %>
  </div>
</div>
</body>
</html>
