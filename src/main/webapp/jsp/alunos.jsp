<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson" %>

<style>
    .details { display: none; }
</style>

<body>
    <div class="container">
        <h2 class="mt-4">Lista de Alunos</h2>
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Nome do Aluno</th>
                    <th>Detalhes</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = dbconnect.getConnection()) {
                        String query = "SELECT * FROM alunos";
                        try (PreparedStatement stmt = conn.prepareStatement(query);
                             ResultSet rs = stmt.executeQuery()) {
                             
                            while (rs.next()) {
                                int alunoId = rs.getInt("aluno_id");
                                String matricula = rs.getString("codigo_matricula");
                                String nome = rs.getString("nome_completo");
                                String dataNascimento = rs.getString("data_nascimento");
                                String endereco = rs.getString("endereco");
                                String telefone = rs.getString("telefone");
                                String email = rs.getString("email");
                %>
                <tr>
                    <td><%= nome %></td>
                    <td>
                        <button class="btn btn-info btn-sm" onclick="toggleDetails(<%= alunoId %>)">Ver detalhes</button>
                    </td>
                </tr>
                <tr id="details-<%= alunoId %>" class="details">
                    <td colspan="2">
                        <strong>Código de Matrícula:</strong> <%= matricula %><br>
                        <strong>Data de Nascimento:</strong> <%= dataNascimento %><br>
                        <strong>Endereço:</strong> <%= endereco %><br>
                        <strong>Telefone:</strong> <%= telefone %><br>
                        <strong>Email:</strong> <%= email %><br>
                        <!-- Botão para carregar disciplinas -->
                        <button class="btn btn-info btn-sm" onclick="window.location.href='disciplinas.jsp?alunoId=<%= alunoId %>'">Ver Disciplinas</button>
                    </td>
                </tr>
                <%
                            }
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='2'>Erro ao carregar os alunos.</td></tr>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>

    <script>
        function toggleDetails(alunoId) {
            var detailsRow = document.getElementById("details-" + alunoId);
            detailsRow.style.display = (detailsRow.style.display === "none") ? "table-row" : "none";
        }
    </script>
</body>
</html>
