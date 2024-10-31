<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>

<style>
    .details { display: none; }
</style>

<body>
    <div class="container">
        <h2 class="mt-4">Lista de Professores</h2>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Nome do Professor</th>
                    <th>Detalhes</th>
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
                      <button class="btn btn-info btn-sm" onclick="toggleDetails(<%= professorId %>)">Ver detalhes</button>
                  </td>
              </tr>
              <tr id="details-<%= professorId %>" class="details">
                  <td colspan="2">
                      <strong>Código de Identificação:</strong> <%= identificacao %><br>
                      <strong>Data de Contratação:</strong> <%= dataContrato %><br>
                      <strong>Telefone:</strong> <%= telefone %><br>
                      <strong>Email:</strong> <%= email %><br>
                      <button class="btn btn-info btn-sm" 
                          onclick="window.location.href='infos_professores.jsp?professorId=<%= professorId %>'">Ver Matérias</button>
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
        function toggleDetails(professorId) {
            console.log("Toggling details for professor ID: " + professorId);
            var detailsRow = document.getElementById("details-" + professorId);
            console.log(detailsRow); // Verifica se a linha de detalhes foi encontrada
            if (detailsRow) {
                detailsRow.style.display = (detailsRow.style.display === "none") ? "table-row" : "none";
            } else {
                console.error("Details row not found for professor ID: " + professorId);
            }
        }
    </script>
</body>
</html>
