<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Alunos</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <style>
        .details { display: none; }
    </style>
</head>
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
                        <button class="btn btn-info btn-sm" onclick="loadDisciplinas(<%= alunoId %>)">Ver Disciplinas</button>
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
            detailsRow.style.display = (detailsRow.style.display === "none" || detailsRow.style.display === "") ? "table-row" : "none";
        }

        function loadDisciplinas(alunoId) {
    console.log("Carregando disciplinas para o aluno com ID:", alunoId); // Log do alunoId
    if (!alunoId) {
        console.error("ID do aluno não fornecido");
        return;
    }

    // Limpa a lista de disciplinas
    document.getElementById("disciplinasList").innerHTML = '';

    // Chama o fetch com o alunoId
    fetch(`/trabalhojulio/DisciplinasServlet?alunoId=${alunoId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na rede');
            }
            return response.json();
        })
        .then(data => {
            // Adiciona as disciplinas à lista
            const disciplinasList = document.getElementById("disciplinasList");
            data.forEach(disciplina => {
                const listItem = document.createElement("li");
                listItem.className = "list-group-item";
                listItem.textContent = `${disciplina.nomeDisciplina} - Status: ${disciplina.status}`;
                disciplinasList.appendChild(listItem);
            });
            // Abre o modal com a lista de disciplinas
            $('#disciplinasModal').modal('show');
        })
        .catch(error => {
            console.error('Erro:', error);
        });
}

    </script>
</body>
</html>