<%-- 
    Document   : caddisciplinas
    Created on : 8 de nov. de 2024, 10:58:39
    Author     : Administrador
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Disciplina</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Cadastrar Disciplina</h2>

        <form action="${pageContext.request.contextPath}/CadastrarDisciplinaServlet" method="post">
            <div class="form-group">
                <label for="codigo">Código da Disciplina</label>
                <input type="text" class="form-control" id="codigo" name="codigo" required>
            </div>

            <div class="form-group">
                <label for="nome">Nome da Disciplina</label>
                <input type="text" class="form-control" id="nome" name="nome" required>
            </div>

            <div class="form-group">
                <label for="carga_horaria">Carga Horária</label>
                <input type="number" class="form-control" id="carga_horaria" name="carga_horaria" required>
            </div>

            <button type="submit" class="btn btn-primary">Cadastrar</button>
        </form>
    </div>
</body>
</html>
