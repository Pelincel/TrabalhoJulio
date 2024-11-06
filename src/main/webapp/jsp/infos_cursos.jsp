<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


<%
    int cursoId = Integer.parseInt(request.getParameter("curso_id"));
    String cursoNome = "";
    String errorMessage = "";
    List<String> turmasList = new ArrayList<>();
    List<Integer> turmaIdsList = new ArrayList<>();
    List<String> anoSemestreList = new ArrayList<>(); // Nova lista para armazenar ano/semestre

    try (Connection conn = dbconnect.getConnection()) {
        // Consulta o nome do curso
        String cursoQuery = "SELECT nome FROM cursos WHERE curso_id = ?";
        try (PreparedStatement cursoStmt = conn.prepareStatement(cursoQuery)) {
            cursoStmt.setInt(1, cursoId);
            try (ResultSet cursoRs = cursoStmt.executeQuery()) {
                if (cursoRs.next()) {
                    cursoNome = cursoRs.getString("nome");
                } else {
                    errorMessage = "Curso não encontrado.";
                }
            }
        }

        // Consulta as turmas do curso
        String turmasQuery = "SELECT t.turma_id, t.nome, t.ano_semestre FROM turmas t " +
                             "JOIN turma_disciplinas td ON t.turma_id = td.turma_id " +
                             "JOIN curso_disciplinas cd ON td.disciplina_id = cd.disciplina_id " +
                             "WHERE cd.curso_id = ? GROUP BY t.turma_id, t.nome, t.ano_semestre";
        try (PreparedStatement turmasStmt = conn.prepareStatement(turmasQuery)) {
            turmasStmt.setInt(1, cursoId);
            try (ResultSet turmasRs = turmasStmt.executeQuery()) {
                while (turmasRs.next()) {
                    String turmaNome = turmasRs.getString("nome");
                    int turmaId = turmasRs.getInt("turma_id");
                    String anoSemestre = turmasRs.getString("ano_semestre"); // Captura o ano/semestre
                    turmasList.add(turmaNome);
                    turmaIdsList.add(turmaId);
                    anoSemestreList.add(anoSemestre); // Adiciona à lista
                }
            }
        }
    } catch (SQLException e) {
        errorMessage = "Erro ao carregar informações do curso: " + e.getMessage();
    } catch (Exception e) {
        errorMessage = "Erro ao carregar informações: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title><%= cursoNome %> - Informações</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/header.css">
    <style>
        .alunos {
            display: none; /* Esconder inicialmente */
            margin-top: 10px;
        }
    </style>
</head>
<body>
     <header class="py-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h3>CeepSystem</h3>
                <a href="home.jsp"><img src="../img/icons/home1.svg" /></a>
            </div>
        </div>
    </header>
    <h1>Detalhes do Curso: <%= cursoNome %></h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>Nome da Turma</th>
                <th>Ano/Semestre</th>
                <th>Ação</th>
            </tr>
        </thead>
        <tbody>
            <%
            // Exibir turmas
            for (int i = 0; i < turmasList.size(); i++) {
                %>
                <tr>
                    <td><%= turmasList.get(i) %></td>
                    <td><%= anoSemestreList.get(i) %></td> <!-- Exibe o ano/semestre -->
                    <td>
                        <button class="ver-alunos" data-turma-id="<%= turmaIdsList.get(i) %>">Ver Alunos</button>
                    </td>
                </tr>
                <%
            }
            %>
        </tbody>
    </table>

    <div id="alunos-container" class="alunos"></div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const buttons = document.querySelectorAll('.ver-alunos');
            buttons.forEach(button => {
                button.addEventListener('click', function() {
                    const turmaId = this.getAttribute('data-turma-id');
                    const alunosContainer = document.getElementById('alunos-container');

                    // Verifica se já está exibindo os alunos para essa turma
                    if (alunosContainer.style.display === 'block' && alunosContainer.dataset.turmaId === turmaId) {
                        alunosContainer.style.display = 'none'; // Esconde se estiver visível
                        alunosContainer.innerHTML = ''; // Limpa o conteúdo
                    } else {
                        loadAlunos(turmaId);
                    }
                });
            });
        });

        function loadAlunos(turmaId) {
            const alunosContainer = document.getElementById('alunos-container');
            alunosContainer.innerHTML = ''; // Limpar conteúdo anterior
            alunosContainer.dataset.turmaId = turmaId; // Armazena o ID da turma

            fetch('functions/buscar_alunos.jsp?turma_id=' + turmaId)
                .then(response => response.text())
                .then(data => {
                    alunosContainer.innerHTML = data;
                    alunosContainer.style.display = 'block'; // Exibir a lista de alunos
                })
                .catch(error => {
                    console.error('Erro ao carregar alunos:', error);
                });
        }
    </script>
</body>
</html>
