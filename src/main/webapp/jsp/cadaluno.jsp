<%-- 
    Document   : cadaluno
    Created on : 7 de nov. de 2024, 11:54:18
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Informações do Professor</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/cadaluno.css">
    <link rel="stylesheet" href="../css/header.css">
</head>
<body>

    <!-- Header (Cabeçalho) -->
        <header class="py-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h3>CeepSystem</h3>
                <a href="home.jsp"><img src="../img/icons/home1.svg" /></a>
            </div>
        </div>
    </header>
    
     <div class="container mt-5">
        <h2 class="text-center mb-4">Cadastro de Aluno</h2>
        
        <form action="${pageContext.request.contextPath}/CadastrarAlunoServlet" method="POST">
        <label for="codigo_matricula">Número da Matrícula:</label>
        <input type="text" id="codigo_matricula" name="codigo_matricula" required>
        <br><br>

        <label for="nome_completo">Nome Completo:</label>
        <input type="text" id="nome_completo" name="nome_completo" required>
        <br><br>

        <label for="data_nascimento">Data de Nascimento:</label>
        <input type="date" id="data_nascimento" name="data_nascimento" required>
        <br><br>

        <label for="endereco">Endereço:</label>
        <input type="text" id="endereco" name="endereco" required>
        <br><br>

        <label for="telefone">Telefone:</label>
        <input type="text" id="telefone" name="telefone" required>
        <br><br>

        <label for="email">E-mail:</label>
        <input type="email" id="email" name="email" required>
        <br><br>

        <button type="submit">Cadastrar</button>
    </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+zQFZd6EGGoI1gE4nRI2WIW5OjM20" crossorigin="anonymous"></script>
</body>
</html>
    
