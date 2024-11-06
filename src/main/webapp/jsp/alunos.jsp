<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>



<style>
    .aluno-details { display: none; }
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
                        <button class="btn btn-info btn-sm" onclick="toggleAlunoDetails(<%= alunoId %>)">Ver detalhes</button>
                    </td>
                </tr>
                <tr id="aluno-details-<%= alunoId %>" class="aluno-details">
                    <td colspan="2">
                        <strong>Código de Matrícula:</strong> <%= matricula %><br>
                        <strong>Data de Nascimento:</strong> <%= dataNascimento %><br>
                        <strong>Endereço:</strong> <%= endereco %><br>
                        <strong>Telefone:</strong> <%= telefone %><br>
                        <strong>Email:</strong> <%= email %><br>
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
        function toggleAlunoDetails(alunoId) {
            var detailsRow = document.getElementById("aluno-details-" + alunoId);
            detailsRow.style.display = (detailsRow.style.display === "none" || detailsRow.style.display === "") ? "table-row" : "none";
        }
    </script>
</body>
</html>
