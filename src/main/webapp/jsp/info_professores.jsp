<%-- 
    Document   : info_professores
    Created on : 1 de nov. de 2024, 18:35:21
    Author     : silva
--%>


<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Informações do Professor</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Informações do Professor</h2>
        <%
            int professorId = Integer.parseInt(request.getParameter("professorId"));
            String errorMessage = "";

            try (Connection conn = dbconnect.getConnection()) {
                // Obter informações básicas do professor
                String queryProfessor = "SELECT * FROM professores WHERE professor_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(queryProfessor)) {
                    stmt.setInt(1, professorId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            String nome = rs.getString("nome_completo");
                            String identificacao = rs.getString("codigo_identificacao");
                            String telefone = rs.getString("telefone");
                            String email = rs.getString("email");
                %>
                            <p><strong>Nome:</strong> <%= nome %></p>
                            <p><strong>Identificação:</strong> <%= identificacao %></p>
                            <p><strong>Telefone:</strong> <%= telefone %></p>
                            <p><strong>Email:</strong> <%= email %></p>
                <%
                        }
                    }
                }

                // Obter especializações do professor
                String queryEspecializacoes = "SELECT e.nome FROM especializacoes e " +
                                              "JOIN professor_especializacoes pe ON e.especializacao_id = pe.especializacao_id " +
                                              "WHERE pe.professor_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(queryEspecializacoes)) {
                    stmt.setInt(1, professorId);
                    try (ResultSet rs = stmt.executeQuery()) {
                %>
                        <h3>Especializações</h3>
                        <ul>
                <%
                        while (rs.next()) {
                            String especializacao = rs.getString("nome");
                %>
                            <li><%= especializacao %></li>
                <%
                        }
                %>
                        </ul>
                <%
                    }
                }

                // Obter turmas que o professor leciona
                String queryTurmas = "SELECT t.nome, t.ano_semestre FROM turmas t " +
                                     "JOIN turma_disciplinas td ON t.turma_id = td.turma_id " +
                                     "WHERE td.professor_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(queryTurmas)) {
                    stmt.setInt(1, professorId);
                    try (ResultSet rs = stmt.executeQuery()) {
                %>
                        <h3>Turmas</h3>
                        <ul>
                <%
                        while (rs.next()) {
                            String turmaNome = rs.getString("nome");
                            String anoSemestre = rs.getString("ano_semestre");
                %>
                            <li><strong>Turma:</strong> <%= turmaNome %> - <%= anoSemestre %></li>
                <%
                        }
                %>
                        </ul>
                <%
                    }
                }

                // Obter disciplinas que o professor leciona
                String queryDisciplinas = "SELECT d.nome FROM disciplinas d " +
                                          "JOIN turma_disciplinas td ON d.disciplina_id = td.disciplina_id " +
                                          "WHERE td.professor_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(queryDisciplinas)) {
                    stmt.setInt(1, professorId);
                    try (ResultSet rs = stmt.executeQuery()) {
                %>
                        <h3>Disciplinas</h3>
                        <ul>
                <%
                        while (rs.next()) {
                            String disciplinaNome = rs.getString("nome");
                %>
                            <li><%= disciplinaNome %></li>
                <%
                        }
                %>
                        </ul>
                <%
                    }
                }

            } catch (Exception e) {
                errorMessage = "Erro ao carregar informações do professor: " + e.getMessage();
                e.printStackTrace();
            }
        %>
        <% if (!errorMessage.isEmpty()) { %>
            <p class="text-danger"><%= errorMessage %></p>
        <% } %>
    </div>
</body>
</html>
