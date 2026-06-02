<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String nombre = request.getParameter("nombre");
String rol = request.getParameter("rol");

if (nombre == null || nombre.isEmpty() || !rol.equals("admin")) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard Admin - Provincias Ecuador</title>
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
        max-width: 1400px;
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
        color: #e74c3c;
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
    
    .tabs {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    
    .tab-buttons {
        display: flex;
        border-bottom: 2px solid #ddd;
    }
    
    .tab-btn {
        flex: 1;
        padding: 15px;
        background: white;
        border: none;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        color: #666;
        border-bottom: 3px solid transparent;
        transition: all 0.3s;
    }
    
    .tab-btn.active {
        color: #e74c3c;
        border-bottom-color: #e74c3c;
    }
    
    .tab-btn:hover {
        background: #f9f9f9;
    }
    
    .tab-content {
        padding: 20px;
        display: none;
    }
    
    .tab-content.active {
        display: block;
    }
    
    .table-wrapper {
        overflow-x: auto;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table th {
        background: #e74c3c;
        color: white;
        padding: 15px;
        text-align: left;
    }
    
    .data-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #ddd;
    }
    
    .data-table tr:nth-child(even) {
        background: #f9f9f9;
    }
    
    .data-table tr:hover {
        background: #f0f0f0;
    }
    
    .action-buttons {
        display: flex;
        gap: 5px;
    }
    
    .btn-small {
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 12px;
        font-weight: bold;
        color: white;
        text-decoration: none;
        transition: opacity 0.3s;
    }
    
    .btn-edit {
        background: #667eea;
    }
    
    .btn-edit:hover {
        opacity: 0.8;
    }
    
    .btn-delete {
        background: #e74c3c;
    }
    
    .btn-delete:hover {
        opacity: 0.8;
    }
    
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }
    
    .modal.show {
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .modal-content {
        background-color: white;
        padding: 30px;
        border-radius: 10px;
        width: 90%;
        max-width: 400px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    }
    
    .modal-content h2 {
        color: #e74c3c;
        margin-bottom: 20px;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        color: #666;
        font-weight: bold;
    }
    
    .form-group input,
    .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
    }
    
    .form-group input:focus,
    .form-group select:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
    }
    
    .modal-buttons {
        display: flex;
        gap: 10px;
        margin-top: 20px;
    }
    
    .btn {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        transition: transform 0.2s;
    }
    
    .btn-save {
        background: #667eea;
        color: white;
    }
    
    .btn-save:hover {
        transform: scale(1.02);
    }
    
    .btn-cancel {
        background: #ddd;
        color: #666;
    }
    
    .btn-cancel:hover {
        background: #ccc;
    }
    
    .role-badge {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
        color: white;
    }
    
    .role-admin {
        background: #e74c3c;
    }
    
    .role-usuario {
        background: #667eea;
    }
    
    .stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-bottom: 20px;
    }
    
    .stat-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        border-radius: 10px;
        text-align: center;
    }
    
    .stat-number {
        font-size: 32px;
        font-weight: bold;
    }
    
    .stat-label {
        font-size: 14px;
        margin-top: 5px;
    }
</style>
</head>
<body>

<div class="container">
    
    <div class="header">
        <div>
            <h1>⚙️ Panel de Administración</h1>
            <p>Gestión completa de usuarios y puntuaciones</p>
        </div>
        <div class="user-info">
            <p><strong><%= nombre %></strong></p>
            <p>Rol: <strong><%= rol %></strong></p>
            <a href="index.html" class="logout-btn">Cerrar Sesión</a>
            
        </div>
    </div>
    
    <!-- Tabs -->
    <div class="tabs">
        <div class="tab-buttons">
            <button class="tab-btn active" onclick="showTab('usuarios')">👥 Gestión de Usuarios</button>
            <button class="tab-btn" onclick="showTab('puntuaciones')">📊 Puntuaciones</button>
        </div>
        
        <!-- Tab: Usuarios -->
        <div id="usuarios" class="tab-content active">
            <div class="stats">
                <%
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
                    
                    // Estadísticas
                    String sqlStats = "SELECT COUNT(*) as total, COUNT(CASE WHEN email IS NOT NULL THEN 1 END) as conEmail, COUNT(CASE WHEN email IS NULL THEN 1 END) as sinEmail FROM usuarios";
                    ps = con.prepareStatement(sqlStats);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                %>
                <div class="stat-card">
                    <div class="stat-number"><%= rs.getInt("total") %></div>
                    <div class="stat-label">Total Usuarios</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= rs.getInt("conEmail") %></div>
                    <div class="stat-label">Con Correo</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><%= rs.getInt("sinEmail") %></div>
                    <div class="stat-label">Invitados</div>
                </div>
                <%
                    }
                    rs.close();
                    ps.close();
                %>
            </div>
            
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Correo</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String sqlUsers = "SELECT id, nombre, email, rol FROM usuarios ORDER BY id";
                        ps = con.prepareStatement(sqlUsers);
                        rs = ps.executeQuery();
                        
                        while(rs.next()) {
                            int id = rs.getInt("id");
                            String usuarioNombre = rs.getString("nombre");
                            String usuarioEmail = rs.getString("email");
                            String usuarioRol = rs.getString("rol");
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= usuarioNombre %></td>
                            <td><%= (usuarioEmail != null && !usuarioEmail.isEmpty() ? usuarioEmail : "<em>Invitado</em>") %></td>
                            <td>
                                <span class="role-badge role-<%= usuarioRol %>">
                                    <%= usuarioRol.toUpperCase() %>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-small btn-edit" onclick="abrirModalRol(<%= id %>, '<%= usuarioNombre %>', '<%= usuarioRol %>')">Cambiar Rol</button>
                                    <button class="btn-small btn-edit" onclick="abrirModalClave(<%= id %>, '<%= usuarioNombre %>')">Cambiar Clave</button>
                                </div>
                            </td>
                        </tr>
                        <%
                        }
                        rs.close();
                        ps.close();
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Tab: Puntuaciones -->
        <div id="puntuaciones" class="tab-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; gap: 10px; flex-wrap: wrap;">
                <div>
                    <h2 style="margin: 0; font-size: 18px; color: #333;">Historial de Puntuaciones</h2>
                    <p style="margin: 5px 0 0; color: #666;">Borra el historial de rankings y las puntuaciones guardadas en la base de datos.</p>
                </div>
                <button id="btn-borrar-todo" class="btn btn-delete" type="button" onclick="borrarTodoHistorial()">🗑️ Borrar todo el historial</button>
            </div>
            <div class="table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Usuario</th>
                            <th>Puntuación</th>
                            <th>Descripción</th>
                            <th>Fecha</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String sqlScores = "SELECT u.nombre, p.puntuacion, p.descripcion, p.fecha FROM puntuaciones p JOIN usuarios u ON p.usuario_id = u.id ORDER BY p.fecha DESC LIMIT 100";
                        ps = con.prepareStatement(sqlScores);
                        rs = ps.executeQuery();
                        
                        boolean tienePuntuaciones = false;
                        while(rs.next()) {
                            tienePuntuaciones = true;
                            String puntNombre = rs.getString("nombre");
                            int puntuacion = rs.getInt("puntuacion");
                            String descripcion = rs.getString("descripcion");
                            Timestamp fecha = rs.getTimestamp("fecha");
                        %>
                        <tr>
                            <td><strong><%= puntNombre %></strong></td>
                            <td><%= puntuacion %></td>
                            <td><%= (descripcion != null ? descripcion : "-") %></td>
                            <td><%= fecha %></td>
                        </tr>
                        <%
                        }
                        
                        if (!tienePuntuaciones) {
                        %>
                        <tr>
                            <td colspan="4" style="text-align: center; color: #999; padding: 20px;">No hay puntuaciones registradas</td>
                        </tr>
                        <%
                        }
                        
                        rs.close();
                        ps.close();
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
</div>

<!-- Modal Cambiar Rol -->
<%
    } catch(Exception e) {
        out.println("Error: " + e);
    }
%>
<div id="modalRol" class="modal">
    <div class="modal-content">
        <h2>Cambiar Rol de Usuario</h2>
        <form action="cambiar_rol.jsp" method="post">
            <input type="hidden" id="usuarioId" name="usuarioId">
            <input type="hidden" name="adminNombre" value="<%= nombre %>">
            <input type="hidden" name="adminRol" value="<%= rol %>">
            
            <div class="form-group">
                <label>Nombre del Usuario</label>
                <input type="text" id="usuarioNombreModal" disabled>
            </div>
            
            <div class="form-group">
                <label>Nuevo Rol</label>
                <select name="nuevoRol" required>
                    <option value="">Selecciona un rol</option>
                    <option value="usuario">Usuario</option>
                    <option value="admin">Administrador</option>
                </select>
            </div>
            
            <div class="modal-buttons">
                <button type="submit" class="btn btn-save">Guardar Cambios</button>
                <button type="button" class="btn btn-cancel" onclick="cerrarModalRol()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Cambiar Contraseña -->
<div id="modalClave" class="modal">
    <div class="modal-content">
        <h2>Cambiar Contraseña</h2>
        <form action="cambiar_clave_admin.jsp" method="post">
            <input type="hidden" id="usuarioIdClave" name="usuarioId">
            <input type="hidden" name="adminNombre" value="<%= nombre %>">
            <input type="hidden" name="adminRol" value="<%= rol %>">
            
            <div class="form-group">
                <label>Nombre del Usuario</label>
                <input type="text" id="usuarioNombreClaveModal" disabled>
            </div>
            
            <div class="form-group">
                <label>Nueva Contraseña</label>
                <input type="password" name="nuevaClave" placeholder="Ingresa la nueva contraseña" required>
            </div>
            
            <div class="form-group">
                <label>Confirmar Contraseña</label>
                <input type="password" name="nuevaClaveConfirm" placeholder="Confirma la contraseña" required>
            </div>
            
            <div class="modal-buttons">
                <button type="submit" class="btn btn-save">Guardar Cambios</button>
                <button type="button" class="btn btn-cancel" onclick="cerrarModalClave()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<script>
    function showTab(tabName) {
        // Ocultar todos los tabs
        const tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(tab => tab.classList.remove('active'));
        
        const buttons = document.querySelectorAll('.tab-btn');
        buttons.forEach(btn => btn.classList.remove('active'));
        
        // Mostrar el tab seleccionado
        document.getElementById(tabName).classList.add('active');
        event.target.classList.add('active');
    }
    
    function abrirModalRol(id, nombre, rol) {
        document.getElementById('usuarioId').value = id;
        document.getElementById('usuarioNombreModal').value = nombre;
        document.getElementById('modalRol').classList.add('show');
    }
    
    function cerrarModalRol() {
        document.getElementById('modalRol').classList.remove('show');
    }
    
    function abrirModalClave(id, nombre) {
        document.getElementById('usuarioIdClave').value = id;
        document.getElementById('usuarioNombreClaveModal').value = nombre;
        document.getElementById('modalClave').classList.add('show');
    }
    
    function cerrarModalClave() {
        document.getElementById('modalClave').classList.remove('show');
    }

    function limpiarRankingLocal() {
        localStorage.removeItem('historialPuntuaciones');
        localStorage.removeItem('puntajeUsuario');
        localStorage.removeItem('nombreUsuario');
        localStorage.removeItem('usuarioId');
        localStorage.removeItem('rolUsuario');
        localStorage.removeItem('quizzesCompletados');
        Object.keys(localStorage).forEach(key => {
            if (key.startsWith('puntos_maximos_') || key.startsWith('textQuiz_')) {
                localStorage.removeItem(key);
            }
        });
    }

    function borrarTodoHistorial() {
        if (!confirm('⚠️ ¿Estás seguro de que deseas borrar todas las puntuaciones del ranking y la base de datos?')) {
            return;
        }

        fetch('borrar_puntuaciones.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'ok') {
                limpiarRankingLocal();
                alert('Se han borrado todas las puntuaciones del ranking y la base de datos.');
                location.reload();
            } else {
                alert('Error al borrar el historial: ' + (data.message || 'Error desconocido.'));
            }
        })
        .catch(error => {
            console.error('Error al borrar puntuaciones:', error);
            alert('Error al intentar borrar las puntuaciones. Revisa la consola del navegador.');
        });
    }

    // Cerrar modal al hacer click fuera
    window.onclick = function(event) {
        const modalRol = document.getElementById('modalRol');
        const modalClave = document.getElementById('modalClave');
        
        if (event.target === modalRol) {
            modalRol.classList.remove('show');
        }
        if (event.target === modalClave) {
            modalClave.classList.remove('show');
        }
    }
</script>

<%
try {
    if (con != null) con.close();
} catch(Exception e) {}
%>

</body>
</html>
