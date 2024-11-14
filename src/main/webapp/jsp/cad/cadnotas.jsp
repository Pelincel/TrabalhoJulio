<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Adicionar Notas</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/header.css">
    <style>
        .form-container {
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            padding: 1.5rem;
        }
    </style>
</head>
<body>

<header class="py-3">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h3>CeepSystem</h3>
            <a href="../home.jsp"><img src="../../img/icons/home1.svg" /></a>
        </div>
    </div>
</header>

<div class="container mt-5">
    <div class="form-container">
        <h4 class="text-center">Adicionar Notas</h4>
        
        <form action="SalvarNotasServlet" method="post">
            <!-- Filtro para Curso -->
<div class="form-group">
    <label for="curso">Curso:</label>
    <select class="form-control" id="curso" name="curso" required>
        <option value="">Selecione o curso</option>
        <% 
            try (Connection conn = dbconnect.getConnection()) {
                String query = "SELECT curso_id, nome FROM cursos";
                try (PreparedStatement stmt = conn.prepareStatement(query);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int cursoId = rs.getInt("curso_id");
                        String cursoNome = rs.getString("nome");
        %>
                        <option value="<%= cursoId %>"><%= cursoNome %></option>
        <%  
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </select>
</div>


            <!-- Filtro para Turma -->
            <div class="form-group">
                <label for="turma">Turma:</label>
                <select class="form-control" id="turma" name="turma" required>
                    <option value="">Selecione a turma</option>
                </select>
            </div>

            <!-- Filtro para Avaliação -->
            <div class="form-group">
                <label for="avaliacao">Avaliação:</label>
                <select class="form-control" id="avaliacao" name="avaliacao" required>
                    <option value="">Selecione a avaliação</option>
                </select>
            </div>

            <!-- Lista de Alunos e suas Notas -->
            <div id="alunos-container">
                <!-- Aqui serão listados os alunos com campos para inserir notas -->
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary">Salvar Notas</button>
            </div>
        </form>
    </div>
</div>

<script>
  document.getElementById('curso').addEventListener('change', function() {
    let cursoId = this.value;
    console.log("Curso selecionado:", cursoId);

    if (cursoId) {
        fetch(`../functions/turmas_notas.jsp?curso_id=${cursoId}`)
            .then(response => {
                if (!response.ok) {
                    console.error("Erro ao carregar turmas:", response.status, response.statusText);
                    throw new Error("Erro ao carregar turmas");
                }
                return response.json();
            })
            .then(data => {
                console.log("Resposta do servidor:", data);
                
                let turmaSelect = document.getElementById('turma');
                turmaSelect.innerHTML = "<option value=''>Selecione a turma</option>";

                data.forEach(turma => {
                    turmaSelect.innerHTML += `<option value="${turma.turma_id}">${turma.nome}</option>`;
                });

                document.getElementById('avaliacao').innerHTML = "<option value=''>Selecione a avaliação</option>";
                document.getElementById('alunos-container').innerHTML = "";
            })
            .catch(error => {
                console.error("Erro:", error);
                alert("Ocorreu um erro ao carregar as turmas. Por favor, tente novamente.");
            });
    } else {
        console.warn("Curso ID está vazio");
    }
});



    // Script para carregar alunos e criar campos de notas quando a avaliação for selecionada
    document.getElementById('avaliacao').addEventListener('change', function() {
        let avaliacaoId = this.value;
        let turmaId = document.getElementById('turma').value();
        let cursoId = document.getElementById('curso').value();
        if (avaliacaoId && turmaId && cursoId) {
            fetch(`../functions/alunos_notas.jsp?curso_id=${cursoId}&turma_id=${turmaId}`)
                .then(response => response.json())
                .then(data => {
                    let alunosContainer = document.getElementById('alunos-container');
                    alunosContainer.innerHTML = "";
                    data.forEach(aluno => {
                        alunosContainer.innerHTML += `
                            <div class="form-group">
                                <label for="nota_${aluno.aluno_id}">${aluno.nome_completo}</label>
                                <input type="number" step="0.01" min="0" max="10" class="form-control" name="nota_${aluno.aluno_id}" id="nota_${aluno.aluno_id}" required>
                            </div>
                        `;
                    });
                });
        }
    });
</script>

</body>
</html>
