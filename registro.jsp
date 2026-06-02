<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registro - Provincias Ecuador</title>

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
  }
  
  .login-card h2 {
    text-align: center;
    color: #333;
    margin-bottom: 10px;
  }
  
  .login-card p {
    text-align: center;
    color: #666;
    margin-bottom: 25px;
    font-size: 14px;
  }
  
  .login-card form {
    display: flex;
    flex-direction: column;
  }
  
  .login-card label {
    color: #333;
    margin-bottom: 5px;
    font-weight: bold;
    font-size: 14px;
  }
  
  .login-card input {
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
  }
  
  .login-card input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
  }
  
  .login-card button {
    padding: 12px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.2s;
  }
  
  .login-card button:hover {
    transform: scale(1.02);
  }
  
  .register {
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
  }
  
  .register a {
    color: #667eea;
    text-decoration: none;
    font-weight: bold;
  }
  
  .register a:hover {
    text-decoration: underline;
  }
  
  .back-home {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #667eea;
    text-decoration: none;
    font-size: 14px;
  }
  
  .back-home:hover {
    text-decoration: underline;
  }
</style>
</head>

<body>

<div class="login-container">

  <div class="login-card">

    <h2>Crear Cuenta</h2>
    <p>Regístrate en Provincias Ecuador</p>

    <form action="guardar.jsp" method="post">

      <label>Nombre</label>
      <input type="text" name="txtNombre" placeholder="Tu nombre completo" required>

      <label>Correo</label>
      <input type="email" name="txtEmail" placeholder="ejemplo@email.com" required>

      <label>Contraseña</label>
      <input type="password" name="txtClave" placeholder="••••••••" required>

      <label>Confirmar contraseña</label>
      <input type="password" name="txtClave2" placeholder="••••••••" required>

      <button type="submit">Registrarse</button>

    </form>

    <p class="register">
      ¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión</a>
    </p>

    <a href="index.html" class="back-home">← Volver al inicio</a>

  </div>

</div>

</body>
</html>
