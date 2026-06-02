<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
response.setContentType("application/json;charset=UTF-8");

Connection con = null;
PreparedStatement ps = null;
try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/proyecto",
        "postgres",
        "1234"
    );

    String sql = "DELETE FROM puntuaciones";
    ps = con.prepareStatement(sql);
    int filasEliminadas = ps.executeUpdate();

    out.print("{\"status\":\"ok\",\"deleted\":" + filasEliminadas + "}");
} catch (Exception e) {
    response.setStatus(500);
    String msg = e.getMessage();
    if (msg == null) msg = "Error interno al borrar las puntuaciones.";
    msg = msg.replace("\"", "'");
    out.print("{\"status\":\"error\",\"message\":\"" + msg + "\"}");
} finally {
    if (ps != null) try { ps.close(); } catch(Exception ex) {}
    if (con != null) try { con.close(); } catch(Exception ex) {}
}
%>