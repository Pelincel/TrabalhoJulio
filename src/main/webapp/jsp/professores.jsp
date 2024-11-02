<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Lista de Professores</title>
    <style>
        .professor-details { display: none; } /* Inicialmente esconde os detalhes dos professores */
    </style>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Lista de Professores</h2>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Nome do Professor</th>
                    <th>A��es</th>
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
                        <button class="btn btn-info btn-sm" onclick="toggleProfessorDetails(<%= professorId %>)">Ver detalhes</button>
                    </td>
                </tr>
                <tr id="professor-details-<%= professorId %>" class="professor-details">
                    <td colspan="2">
                        <strong>C�digo de Identifica��o:</strong> <%= identificacao %><br>
                        <strong>Data de Contrata��o:</strong> <%= dataContrato %><br>
                        <strong>Telefone:</strong> <%= telefone %><br>
                        <strong>Email:</strong> <%= email %><br>
                        <button class="btn btn-secondary btn-sm mt-2" onclick="window.location.href='info_professores.jsp?professorId=<%= professorId %>'">
            Mais Informa��es
        </button>
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

    <script>
        // Fun��o espec�fica para detalhes de professores
        function toggleProfessorDetails(professorId) {
            var detailsRow = document.getElementById("professor-details-" + professorId);
            if (detailsRow) {
                detailsRow.style.display = (detailsRow.style.display === "none" || detailsRow.style.display === "") ? "table-row" : "none";
            } else {
                console.error("Detalhes n�o encontrados para o professor com ID: " + professorId);
            }
        }
    </script>
</body>
</html>
