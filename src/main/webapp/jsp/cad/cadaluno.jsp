<%-- 
    Document   : cadaluno
    Created on : 7 de nov. de 2024, 11:54:18
    Author     : Administrador
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Aluno</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/header.css">
    <link rel="stylesheet" href="../../css/cadastro.css">
    <style>
    
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

    <div class="container form-container mt-4 bloco">
        <h4>Cadastro de Aluno</h4>
        <form action="${pageContext.request.contextPath}/CadastrarAlunoServlet" method="post">
            <div class="row">

                <div class="col-md-6 col-12 mb-3">
                    <label for="matricula">Matrícula:</label>
                    <input type="text" name="matricula" id="matricula" class="form-control medium-input" required>
                </div>

                <div class="col-md-6 col-12 mb-3">
                    <label for="nome">Nome Completo:</label>
                    <input type="text" name="nome" id="nome" class="form-control medium-input" required>
                </div>

                <div class="col-md-6 col-12 mb-3">
                    <label for="dataNascimento">Data de Nascimento:</label>
                    <input type="date" name="data_nascimento" id="dataNascimento" class="form-control medium-input" required>
                </div>

                <div class="col-md-6 col-12 mb-3">
                    <label for="telefone">Telefone:</label>
                    <input type="text" name="telefone" id="telefone" class="form-control medium-input" required>
                </div>

                <div class="col-md-12 col-12 mb-3">
                    <label for="endereco">Endereço:</label>
                    <textarea name="endereco" id="endereco" class="form-control medium-input" rows="2" required></textarea>
                </div>
                
                <div class="col-md-6 col-12 mb-3">
                    <label for="email">Email:</label>
                    <input type="email" name="email" id="email" class="form-control medium-input" required>
                </div>

                <div class="col-md-6 col-12 mb-3">
                    <label for="curso">Selecione o Curso:</label>
                    <select id="curso" name="curso" class="form-control medium-input" onchange="fetchTurmas()" required>
                        <option value="">Selecione um curso</option>
                        <% 
                            try (Connection conn = dbconnect.getConnection()) {
                                String queryCursos = "SELECT curso_id, nome FROM cursos";
                                try (PreparedStatement stmtCursos = conn.prepareStatement(queryCursos)) {
                                    ResultSet rsCursos = stmtCursos.executeQuery();
                                    while (rsCursos.next()) {
                        %>
                        <option value="<%= rsCursos.getInt("curso_id") %>"><%= rsCursos.getString("nome") %></option>
                        <% 
                                    }
                                }
                            } catch (SQLException | ClassNotFoundException e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>

                <div class="col-md-6 col-12 mb-3">
                    <label for="turma">Turma:</label>
                    <select name="turma" id="turma" class="form-control medium-input" required>
                        <option value="">Selecione uma turma</option>
                    </select>
                </div>
            </div>

            <div class="mt-4">
                <button type="submit" class="btn btn-danger">Cadastrar Aluno</button>
            </div>
        </form>
    </div>

    <script>
        function fetchTurmas() {
            const cursoSelect = document.getElementById("curso");
            const cursoId = cursoSelect.value;
            const turmaSelect = document.getElementById("turma");

            if (!cursoId || cursoId === "") {
                turmaSelect.innerHTML = '<option value="">Selecione um curso válido</option>';
                return;
            }

            turmaSelect.innerHTML = '<option value="">Carregando...</option>';

            const contextPath = "<%= request.getContextPath() %>";
            const url = contextPath + "/jsp/functions/buscar_turmas.jsp?cursoId=" + encodeURIComponent(cursoId);

            fetch(url)
                .then(response => response.text())
                .then(data => {
                    turmaSelect.innerHTML = data;
                })
                .catch(error => {
                    console.error('Erro ao buscar turmas:', error);
                    turmaSelect.innerHTML = '<option value="">Erro ao carregar turmas</option>';
                });
        }
    </script>
</body>
</html>
