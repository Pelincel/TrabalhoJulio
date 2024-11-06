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
  <div class="sidebar">
        <h2 class="text-center">Menu</h2>
        <a href="#" onclick="showSection('home')">Home</a>
        <a href="#" onclick="showSection('alunos')">Alunos</a>
        <a href="#" onclick="showSection('professores')">Professores</a>
        <a href="#" onclick="showSection('cursos')">Cursos</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="header">
            <h1>Página Principal</h1>
            <p>Bem-vindo à plataforma de gestão educacional</p>
        </div>
        
        <!-- Sessões incluídas dinamicamente -->
        <div id="home-section" class="main-section">
           
        </div>
        <div id="alunos-section" class="main-section" style="display:none;">
            <jsp:include page="alunos.jsp" />
        </div>
        <div id="professores-section" class="main-section" style="display:none;">
            <jsp:include page="professores.jsp" />
        </div>
        
        <div id="cursos-section" class="main-section" style="display:none;">
            <jsp:include page="cursos.jsp" />
        </div>
    </div>

    <script>
        function showSection(sectionId) {
            // Oculta todas as seções
            document.querySelectorAll('.main-section').forEach(section => section.style.display = 'none');
            // Mostra a seção selecionada
            document.getElementById(sectionId + '-section').style.display = 'block';
        }
    </script>

</body>
</html>

