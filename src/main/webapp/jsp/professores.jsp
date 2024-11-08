<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Professores</title>
    <style>
        .professor-details { display: none; }
        /* Estilo para a tabela com rolagem */
        .scrollable-table {
            max-height: 400px; /* Defina a altura máxima conforme necessário */
            overflow-y: auto;  /* Permite rolagem vertical */
        }
    </style>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="">
        <h2 class="mt-4">Lista de Professores</h2>
        <div class="scrollable-table">
            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Nome do Professor</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String errorMessage = "";
                        try (Connection conn = dbconnect.getConnection()) {
                            String query = "SELECT * FROM professores";
                            try (PreparedStatement stmt = conn.prepareStatement(query);
                                 ResultSet rs = stmt.executeQuery()) {

                                while (rs.next()) {
                                    int professorId = rs.getInt("professor_id");
                                    String identificacao = rs.getString("codigo_identificacao");
                                    String nome = rs.getString("nome_completo");
                                    String dataContrato = rs.getString("data_contratacao");
                                    String telefone = rs.getString("telefone");
                                    String email = rs.getString("email");
                    %>
                    <tr>
                        <td><%= nome %></td>
                        <td>
                            <!-- Botão para Ver Detalhes -->
                            <button class="btn btn-info btn-sm" onclick="toggleProfessorDetails(<%= professorId %>)">Ver detalhes</button>
                            
                            <!-- Botão para Excluir -->
                            <form action="${pageContext.request.contextPath}/ExcluirProfessorServlet" method="post" style="display:inline;">
                                <input type="hidden" name="professorId" value="<%= professorId %>">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Tem certeza que deseja excluir este professor?')">Excluir</button>
                            </form>
                        </td>
                    </tr>
                    <tr id="professor-details-<%= professorId %>" class="professor-details">
                        <td colspan="2">
                            <strong>Código de Identificação:</strong> <%= identificacao %><br>
                            <strong>Data de Contratação:</strong> <%= dataContrato %><br>
                            <strong>Telefone:</strong> <%= telefone %><br>
                            <strong>Email:</strong> <%= email %><br>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            errorMessage = "Erro ao carregar os professores: " + e.getMessage();
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
    </div>

    <script>
        function toggleProfessorDetails(professorId) {
            var detailsRow = document.getElementById("professor-details-" + professorId);
            if (detailsRow) {
                detailsRow.style.display = (detailsRow.style.display === "none" || detailsRow.style.display === "") ? "table-row" : "none";
            }
        }
    </script>
</body>
</html>
