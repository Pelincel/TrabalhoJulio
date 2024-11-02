<%-- 
    Document   : cursos
    Created on : 1 de nov. de 2024, 18:58:22
    Author     : silva
--%>

<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Cursos</title>
    <style>
        .curso-details { display: none; }
    </style>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Lista de Cursos</h2>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Nome do Curso</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String errorMessage = "";
                    try (Connection conn = dbconnect.getConnection()) {
                        String query = "SELECT * FROM cursos";
                        try (PreparedStatement stmt = conn.prepareStatement(query);
                             ResultSet rs = stmt.executeQuery()) {

                            while (rs.next()) {
                                int cursoId = rs.getInt("curso_id");
                                String nomeCurso = rs.getString("nome");
                %>
                <tr>
                    <td><%= nomeCurso %></td>
                    <td>
                        <button class="btn btn-info btn-sm" onclick="toggleCursoDetails(<%= cursoId %>)">Ver detalhes</button>
                    </td>
                </tr>
                <tr id="curso-details-<%= cursoId %>" class="curso-details">
                    <td colspan="2">
                        <strong>Disciplinas do Curso:</strong>
                        <ul>
                            <%
                                String disciplinasQuery = "SELECT d.nome FROM curso_disciplinas cd " +
                                                          "JOIN disciplinas d ON cd.disciplina_id = d.disciplina_id " +
                                                          "WHERE cd.curso_id = ?";
                                try (PreparedStatement disciplinasStmt = conn.prepareStatement(disciplinasQuery)) {
                                    disciplinasStmt.setInt(1, cursoId);
                                    try (ResultSet disciplinasRs = disciplinasStmt.executeQuery()) {
                                        while (disciplinasRs.next()) {
                                            String disciplinaNome = disciplinasRs.getString("nome");
                            %>
                            <li><%= disciplinaNome %></li>
                            <%
                                        }
                                    }
                                } catch (SQLException e) {
                                    errorMessage = "Erro ao carregar disciplinas: " + e.getMessage();
                                }
                            %>
                        </ul>
                        <a href="infos_cursos.jsp?curso_id=<%= cursoId %>" class="btn btn-secondary btn-sm mt-2">Mais informações</a>
                    </td>
                </tr>
                <%
                            }
                        }
                    } catch (Exception e) {
                        errorMessage = "Erro ao carregar os cursos: " + e.getMessage();
                        e.printStackTrace();
                    }
                %>
                <% if (!errorMessage.isEmpty()) { %>
                    <tr>
                        <td colspan="2" class="text-danger"><%= errorMessage %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
        function toggleCursoDetails(cursoId) {
            var detailsRow = document.getElementById("curso-details-" + cursoId);
            if (detailsRow) {
                detailsRow.style.display = (detailsRow.style.display === "none" || detailsRow.style.display === "") ? "table-row" : "none";
            } else {
                console.error("Detalhes não encontrados para o curso com ID: " + cursoId);
            }
        }
    </script>
</body>
</html>

