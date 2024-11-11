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
</head>
<body>
    <div class="container mt-5">
        <h4>Cadastro de Aluno</h4>
        <form action="${pageContext.request.contextPath}/CadastrarAlunoServlet" method="post">
            <!-- Campo para Matrícula -->
            <div class="form-group">
                <label for="matricula">Matrícula:</label>
                <input type="text" name="matricula" id="matricula" class="form-control" required>
            </div>

            <!-- Campo para Nome Completo -->
            <div class="form-group">
                <label for="nome">Nome Completo:</label>
                <input type="text" name="nome" id="nome" class="form-control" required>
            </div>

             <!-- Data de Nascimento -->
            <!-- Data de Nascimento -->
<div class="form-group">
    <label for="dataNascimento">Data de Nascimento:</label>
    <input type="date" name="data_nascimento" id="dataNascimento" class="form-control" required>
</div>


            <!-- Endereço -->
            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <textarea name="endereco" id="endereco" class="form-control" rows="3" required></textarea>
            </div>

            <!-- Telefone -->
            <div class="form-group">
                <label for="telefone">Telefone:</label>
                <input type="text" name="telefone" id="telefone" class="form-control" required>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>
            
            <!-- Selecionar Curso -->
            <div class="form-group">
               <label for="curso">Selecione o Curso:</label>
<select id="curso" name="curso" class="form-control" onchange="fetchTurmas()">
    <option value="">Selecione um curso</option>
    <% 
        // Carregar cursos do banco de dados
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
            <!-- Selecionar Turma -->
            <div class="form-group">
                <label for="turma">Turma:</label>
                <select name="turma" id="turma" class="form-control" required>
                    <option value="">Selecione uma turma</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Cadastrar Aluno</button>
        </form>
    </div>

<script>
    function fetchTurmas() {
        const cursoSelect = document.getElementById("curso");
        const cursoId = cursoSelect.value;
        const turmaSelect = document.getElementById("turma");

        // Verifique se um curso foi selecionado antes de fazer a requisição
        if (!cursoId || cursoId === "") {
            turmaSelect.innerHTML = '<option value="">Selecione um curso válido</option>';
            return;
        }

        // Limpar as opções anteriores
        turmaSelect.innerHTML = '<option value="">Carregando...</option>';

        // Definir o contexto da aplicação no lado do cliente
        const contextPath = "<%= request.getContextPath() %>";
        const url = contextPath + "/jsp/functions/buscar_turmas.jsp?cursoId=" + encodeURIComponent(cursoId);

        // Fazer a requisição usando fetch
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