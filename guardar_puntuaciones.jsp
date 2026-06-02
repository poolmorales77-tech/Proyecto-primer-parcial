<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
String usuarioIdStr = request.getParameter("usuarioId");
String puntuacionStr = request.getParameter("puntuacion");
String descripcion = request.getParameter("descripcion");
if (descripcion == null) {
    descripcion = "";
}

response.setContentType("application/json;charset=UTF-8");

if (usuarioIdStr == null || usuarioIdStr.trim().isEmpty() || puntuacionStr == null || puntuacionStr.trim().isEmpty()) {
    out.print("{\"status\":\"error\",\"message\":\"Faltan parámetros obligatorios.\"}");
    return;
}

Connection con = null;
PreparedStatement ps = null;
try {
    int usuarioId = Integer.parseInt(usuarioIdStr);
    int puntuacion = Integer.parseInt(puntuacionStr);

    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/proyecto",
        "postgres",
        "1234"
    );

    String sql = "INSERT INTO puntuaciones(usuario_id, puntuacion, descripcion) VALUES(?, ?, ?)";
    ps = con.prepareStatement(sql);
    ps.setInt(1, usuarioId);
    ps.setInt(2, puntuacion);
    ps.setString(3, descripcion);
    ps.executeUpdate();

    out.print("{\"status\":\"ok\"}");
} catch (NumberFormatException nfe) {
    response.setStatus(400);
    out.print("{\"status\":\"error\",\"message\":\"Los parámetros de usuario o puntaje no son válidos.\"}");
} catch (Exception e) {
    response.setStatus(500);
    String msg = e.getMessage();
    if (msg == null) msg = "Error interno al guardar la puntuación.";
    msg = msg.replace("\"", "'");
    out.print("{\"status\":\"error\",\"message\":\"" + msg + "\"}");
} finally {
    if (ps != null) try { ps.close(); } catch(Exception ex) {}
    if (con != null) try { con.close(); } catch(Exception ex) {}
}
%>