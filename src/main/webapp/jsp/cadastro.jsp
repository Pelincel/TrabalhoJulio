<%-- 
    Document   : cadastro.jsp
    Created on : 30 de out. de 2024, 11:15:09
    Author     : Administrador
--%>

<%
    if (session.getAttribute("usuario_logado") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon">
    <link href="../css/index.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Letterbook - Login</title>
</head>

<body>
<div class="login-container">
    <div class="login-form">
        <h3 class="text-center mb-4">Cadastro</h3>
        <form action="${pageContext.request.contextPath}/CadastroServlet" method="post">
            <div class="form-group">
                <label for="nome_usuario">Nome de Usuário</label>
                <input type="text" class="form-control" name="nome_usuario" id="nome_usuario" placeholder="Digite seu nome de usuário" required>
            </div>
            <div class="form-group">
                <label for="email">E-mail</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="Digite seu e-mail" required>
            </div>
            <div class="form-group">
                <label for="password">Senha</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="Digite sua senha" required>
            </div>
            <!-- Campo oculto para o tipo de usuário -->
            <input type="hidden" name="tipo_usuario" value="professor">
            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-primary mt-3">Cadastrar</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>