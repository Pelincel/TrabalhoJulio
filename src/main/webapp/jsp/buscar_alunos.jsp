<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<%
    int turmaId = Integer.parseInt(request.getParameter("turma_id"));
    StringBuilder alunosHtml = new StringBuilder();

    try (Connection conn = dbconnect.getConnection()) {
        // Consulta os alunos da turma
        String alunosQuery = "SELECT a.nome_completo FROM alunos a " +
                             "JOIN matriculas m ON a.aluno_id = m.aluno_id " +
                             "WHERE m.turma_id = ?";
        try (PreparedStatement alunosStmt = conn.prepareStatement(alunosQuery)) {
            alunosStmt.setInt(1, turmaId);
            try (ResultSet alunosRs = alunosStmt.executeQuery()) {
                if (alunosRs.next()) {
                    alunosHtml.append("<ul>");
                    do {
                        String alunoNome = alunosRs.getString("nome_completo");
                        alunosHtml.append("<li>").append(alunoNome).append("</li>");
                    } while (alunosRs.next());
                    alunosHtml.append("</ul>");
                } else {
                    alunosHtml.append("<p>Nenhum aluno matriculado nesta turma.</p>");
                }
            }
        }
    } catch (SQLException e) {
        alunosHtml.append("<p>Erro ao carregar alunos: ").append(e.getMessage()).append("</p>");
    }

    out.print(alunosHtml.toString());
%>
