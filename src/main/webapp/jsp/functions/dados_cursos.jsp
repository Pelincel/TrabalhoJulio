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

        // Consulta SQL com ajuste para contar alunos matriculados no curso correto
        String sql = "SELECT c.nome AS curso, COUNT(m.aluno_id) AS total_alunos " +
                     "FROM cursos c " +
                     "JOIN curso_turmas ct ON c.curso_id = ct.curso_id " + // Relaciona cursos com turmas
                     "JOIN turmas t ON ct.turma_id = t.turma_id " +
                     "JOIN turma_disciplinas td ON t.turma_id = td.turma_id " + 
                     "JOIN disciplinas d ON td.disciplina_id = d.disciplina_id " +
                     "LEFT JOIN matriculas m ON t.turma_id = m.turma_id AND m.curso_id = c.curso_id " + // Garante que a matrícula é do curso específico
                     "GROUP BY c.curso_id;";

        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        // Preencher listas com os dados dos cursos e número de alunos
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
