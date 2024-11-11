<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<style>
    .table-container {
        max-height: 400px; /* Ajuste a altura conforme necessário */
        overflow-y: auto;
        margin-top: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 10px;
    }

    .aluno-details { 
        display: none; 
    }
</style>

<body>
        <div class="table-container">
            <table class="table table-bordered ">
                <thead>
                    <tr>
                        <th>Nome do Aluno</th>
                        <th>Ações</th>
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
                            <a href="${pageContext.request.contextPath}/ExcluirAlunoServlet?alunoId=<%= alunoId %>" class="btn btn-danger btn-sm" onclick="return confirm('Tem certeza que deseja excluir este aluno?');">Excluir</a>
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
