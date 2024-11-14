<%@page import="java.sql.*" %>
<%@page contentType="application/json" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%
    String cursoId = request.getParameter("curso_id");
    String turmaId = request.getParameter("turma_id");
    response.setContentType("application/json");
    
    try (Connection conn = dbconnect.getConnection()) {
        // Consulta os alunos matriculados no curso e na turma
        String query = "SELECT a.aluno_id, a.nome_completo " +
                       "FROM alunos a " +
                       "JOIN matriculas m ON m.aluno_id = a.aluno_id " +
                       "WHERE m.curso_id = ? AND m.turma_id = ?";
                       
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(cursoId));
            stmt.setInt(2, Integer.parseInt(turmaId));
            ResultSet rs = stmt.executeQuery();
            
            StringBuilder jsonResponse = new StringBuilder("[");
            while (rs.next()) {
                jsonResponse.append("{");
                jsonResponse.append("\"aluno_id\": ").append(rs.getInt("aluno_id")).append(",");
                jsonResponse.append("\"nome_completo\": \"").append(rs.getString("nome_completo")).append("\"");
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
