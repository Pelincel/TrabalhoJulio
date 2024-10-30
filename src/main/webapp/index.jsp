<%-- 
    Document   : index
    Created on : 30 de out. de 2024, 10:55:55
    Author     : Administrador
--%>


<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<% if (errorMessage != null) { %>
    <div class="alert alert-danger text-center">
        <%= errorMessage %>
    </div>
<% } %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="../img/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="css/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Letterbook - Login</title>
    <style>
 
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-form">
        <h3 class="text-center mb-4">Login</h3>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
    <div class="form-group">
        <label for="email">E-mail</label>
        <input type="email" class="form-control" name="email" id="email" placeholder="Digite seu e-mail" required>
    </div>
    <div class="form-group">
        <label for="password">Senha</label>
        <input type="password" class="form-control" name="password" id="password" placeholder="Digite sua senha" required>
    </div>
    <div class="d-flex justify-content-center">
        <button type="submit" class="btn btn-primary mt-3">Entrar</button>
    </div>
    <div class="text-center mt-3">
        <a href="jsp/cadastro.jsp">Cadastre-se</a>
    </div>
</form>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>