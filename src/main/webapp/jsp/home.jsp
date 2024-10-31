<%-- 
    Document   : home
    Created on : 30 de out. de 2024, 20:02:15
    Author     : silva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Página Principal</title>
    <style>
        body {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }
        .sidebar a {
            color: #fff;
            text-decoration: none;
            padding: 10px;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            flex-grow: 1;
            padding: 20px;
        }
        .header {
            background-color: #007bff;
            color: #fff;
            padding: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2 class="text-center">Menu</h2>
        <a href="#home">Home</a>
        <a href="#alunos">Alunos</a>
        <a href="#professores">Professores</a>
        <a href="#disciplinas">Disciplinas</a>
        <a href="#turmas">Turmas</a>
        <a href="#cursos">Cursos</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <!-- Header -->
        <div class="header">
            <h1>Página Principal</h1>
            <p>Bem-vindo à plataforma de gestão educacional</p>
        </div>
        
        <!-- Main Section -->
        <div class="main-section mt-4">
            <h2>SE CHEGOU AQUI, FUNCIONOU</h2>
            <p>Escolha uma opção no menu para continuar.</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+7hZp6YI1bo4VOA3BXyZsTobEfzq8" crossorigin="anonymous"></script>
</body>
</html>

