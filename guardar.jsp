<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%

String nombre = request.getParameter("txtNombre");
String email = request.getParameter("txtEmail");
String clave = request.getParameter("txtClave");
String clave2 = request.getParameter("txtClave2");

if(!clave.equals(clave2)){
    %>
    <!DOCTYPE html>
    <html lang="es">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Provincias Ecuador</title>
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
        color: #e74c3c;
        margin-bottom: 15px;
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
      }
    </style>
    </head>
    <body>
    <div class="login-container">
      <div class="login-card">
        <h2>Las contraseñas no coinciden</h2>
        <p>Por favor, verifica que ambas contraseñas sean iguales.</p>
        <a href="registro.jsp" class="back-home">Volver al registro</a>
      </div>
    </div>
    </body>
    </html>
    <%
    return;
}

Connection con = null;
PreparedStatement ps = null;
boolean registroExitoso = false;

try{

    Class.forName("org.postgresql.Driver");

    con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/proyecto",
        "postgres",
        "1234"
    );

    String sql = "INSERT INTO usuarios(nombre, email, clave, rol) VALUES(?,?,?,?)";

    ps = con.prepareStatement(sql);

    ps.setString(1, nombre);
    ps.setString(2, email);
    ps.setString(3, clave);
    ps.setString(4, "usuario");

    ps.executeUpdate();
    registroExitoso = true;

}catch(Exception e){

    %>
    <!DOCTYPE html>
    <html lang="es">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Provincias Ecuador</title>
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
        color: #e74c3c;
        margin-bottom: 15px;
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
      }
    </style>
    </head>
    <body>
    <div class="login-container">
      <div class="login-card">
        <h2>Error en el registro</h2>
        <p><%= e.getMessage() %></p>
        <a href="registro.jsp" class="back-home">Volver al registro</a>
      </div>
    </div>
    </body>
    </html>
    <%
    return;

}finally {
    if (ps != null) try { ps.close(); } catch(Exception e) {}
    if (con != null) try { con.close(); } catch(Exception e) {}
}

if(registroExitoso) {
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registro Exitoso - Provincias Ecuador</title>
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
    color: #27ae60;
    margin-bottom: 15px;
  }
  
  .login-card p {
    color: #666;
    margin-bottom: 10px;
    font-size: 14px;
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

        <h2>¡Usuario registrado correctamente!</h2>

        <p><strong>Nombre:</strong> <%= nombre %></p>

        <p><strong>Correo:</strong> <%= email %></p>

        <p style="color: #27ae60; font-weight: bold; margin-top: 15px;">Tu cuenta ha sido creada exitosamente</p>

        <a href="login.jsp" class="back-home">
            Ir al Login
        </a>

    </div>

</div>

</body>
</html>

<% } %>
