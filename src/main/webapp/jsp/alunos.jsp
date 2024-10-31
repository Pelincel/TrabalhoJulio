<%-- 
    Document   : alunos.jsp
    Created on : 31 de out. de 2024, 08:48:49
    Author     : Administrador
--%>

<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

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
                        <button class="btn btn-secondary mt-2" onclick="loadDisciplinas(<%= alunoId %>)">Ver Disciplinas</button>
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

    <!-- Modal para Exibir Disciplinas -->
    <div class="modal fade" id="disciplinasModal" tabindex="-1" aria-labelledby="disciplinasModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="disciplinasModalLabel">Disciplinas do Aluno</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <ul id="disciplinasList" class="list-group"></ul>
                </div>
            </div>
        </div>
    </div>

   
    <script>
        function toggleDetails(alunoId) {
            var detailsRow = document.getElementById("details-" + alunoId);
            detailsRow.style.display = (detailsRow.style.display === "none") ? "table-row" : "none";
        }

        function loadDisciplinas(alunoId) {
    const disciplinasList = document.getElementById("disciplinasList");
    disciplinasList.innerHTML = "Carregando...";

    // Caminho dinâmico usando contextPath
    fetch(`${pageContext.request.contextPath}/DisciplinasServlet?alunoId=${alunoId}`)
        .then(response => response.json())
        .then(data => {
            disciplinasList.innerHTML = "";
            if (data.length === 0) {
                disciplinasList.innerHTML = "<li class='list-group-item'>Nenhuma disciplina encontrada</li>";
            } else {
                data.forEach(disciplina => {
                    disciplinasList.innerHTML += `<li class='list-group-item'>${disciplina.nomeDisciplina} - Status: ${disciplina.status}</li>`;
                });
            }
            new bootstrap.Modal(document.getElementById("disciplinasModal")).show();
        })
        .catch(error => {
            disciplinasList.innerHTML = "<li class='list-group-item'>Erro ao carregar disciplinas</li>";
        });
}


    </script>
</body>
</html>
