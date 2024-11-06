<%@ page contentType="application/json; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%
    List<String> cursos = new ArrayList<>();
    List<Integer> alunosPorCurso = new ArrayList<>();
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Conectar ao banco de dados
        conn = dbconnect.getConnection();

        // Consulta SQL
        String sql = "SELECT c.nome AS curso, COUNT(m.aluno_id) AS total_alunos " +
                     "FROM cursos c " +
                     "JOIN curso_disciplinas cd ON c.curso_id = cd.curso_id " +
                     "JOIN disciplinas d ON cd.disciplina_id = d.disciplina_id " +
                     "JOIN turma_disciplinas td ON d.disciplina_id = td.disciplina_id " +
                     "JOIN turmas t ON td.turma_id = t.turma_id " +
                     "LEFT JOIN matriculas m ON t.turma_id = m.turma_id " +
                     "GROUP BY c.curso_id;";

        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        // Preencher listas
        while (rs.next()) {
            cursos.add(rs.getString("curso"));
            alunosPorCurso.add(rs.getInt("total_alunos"));
        }

        // Convertendo os dados para formato JSON
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"cursos\": ").append(new com.google.gson.Gson().toJson(cursos)).append(",");
        json.append("\"alunosPorCurso\": ").append(new com.google.gson.Gson().toJson(alunosPorCurso));
        json.append("}");

        // Retornar o JSON
        response.getWriter().write(json.toString());
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
