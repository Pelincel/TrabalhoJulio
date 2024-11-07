<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/home.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <title>Página Principal</title>
    <style>
     
    </style>
</head>
<body>

    <!-- Barra de Navegação -->
    <nav class="navbar navbar-expand-lg headertop">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">CeepSystem</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="showSection('home')">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="showSection('alunos')">Alunos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="showSection('professores')">Professores</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="showSection('cursos')">Cursos</a>
                    </li>
                </ul>
                <a href="home.jsp"><img src="../img/icons/home1.svg" /></a>
            </div>
        </div>
    </nav>

  <!-- Conteúdo Principal -->
<div class="container">
    <div id="home-section" class="main-section">
        
        <h3 class="h3 text-center">Informações Gerais</h3>
        <canvas id="myChart" width="400" height="200"></canvas>
        
        <!-- Botões lado a lado -->
        <div class="button-container">
            <button class="btn btn-primary btn-sm">ALUNOS</button>
            <button class="btn btn-primary btn-sm">ALUNOS</button>
            <button class="btn btn-primary btn-sm">ALUNOS</button>
            <button class="btn btn-primary btn-sm">ALUNOS</button>
        </div>
    </div>
    <div id="alunos-section" class="main-section">
        <jsp:include page="alunos.jsp" />
    </div>
    <div id="professores-section" class="main-section">
        <jsp:include page="professores.jsp" />
    </div>
    <div id="cursos-section" class="main-section">
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
    <script src="../js/graphics/alunos_cursos.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+zQFZd6EGGoI1gE4nRI2WIW5OjM20" crossorigin="anonymous"></script>
</body>
</html>
