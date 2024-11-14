<%@page import="java.sql.*" %>
<%@page contentType="application/json" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%
    String cursoId = request.getParameter("curso_id");
    String turmaId = request.getParameter("turma_id");
    response.setContentType("application/json");
    
    try (Connection conn = dbconnect.getConnection()) {
        // Consulta as avaliações associadas à turma e curso selecionados
        String query = "SELECT a.avaliacao_id, a.descricao " +
                       "FROM avaliacoes a " +
                       "JOIN disciplina_disciplinas dd ON dd.disciplina_id = a.disciplina_id " +
                       "JOIN turma_disciplinas td ON td.disciplina_id = dd.disciplina_id " +
                       "WHERE td.turma_id = ? AND dd.curso_id = ?";
                       
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(turmaId));
            stmt.setInt(2, Integer.parseInt(cursoId));
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder jsonResponse = new StringBuilder("[");
            while (rs.next()) {
                jsonResponse.append("{");
                jsonResponse.append("\"avaliacao_id\": ").append(rs.getInt("avaliacao_id")).append(",");
                jsonResponse.append("\"descricao\": \"").append(rs.getString("descricao")).append("\"");
                jsonResponse.append("},");
            }
            if (jsonResponse.length() > 1) {
                jsonResponse.deleteCharAt(jsonResponse.length() - 1); // Remove the last comma
            }
            jsonResponse.append("]");
            out.print(jsonResponse.toString());
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
