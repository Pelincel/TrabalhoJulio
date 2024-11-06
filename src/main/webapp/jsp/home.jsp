<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/home.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery -->
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
            
              <h1>Visão Geral do Sistema</h1>
    <canvas id="myChart" width="400" height="200"></canvas>
         
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
        
          $.ajax({
            url: "functions/dados_cursos.jsp",  // URL do JSP que retorna os dados em JSON
            method: "GET",
            success: function(response) {
                // Extraindo os dados do JSON retornado
                var cursos = response.cursos;
                var alunosPorCurso = response.alunosPorCurso;

                // Verificando se os dados estão corretos
                console.log(cursos);
                console.log(alunosPorCurso);

                // Criando o gráfico com os dados recebidos
                var ctx = document.getElementById('myChart').getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: cursos,  // Cursos
                        datasets: [{
                            label: 'Total de Alunos por Curso',
                            data: alunosPorCurso,  // Total de alunos por curso
                             backgroundColor: [
                'rgba(255, 99, 132, 0.2)', 
                'rgba(54, 162, 235, 0.2)', 
                'rgba(255, 206, 86, 0.2)', 
                'rgba(75, 192, 192, 0.2)'
            ], // Cores diferentes para cada barra
            borderColor: [
                'rgba(255, 99, 132, 1)', 
                'rgba(54, 162, 235, 1)', 
                'rgba(255, 206, 86, 1)', 
                'rgba(75, 192, 192, 1)'
            ], // Cores diferentes para as bordas
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("Erro na requisição AJAX:", error);
            }
        });
    </script>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+zQFZd6EGGoI1gE4nRI2WIW5OjM20" crossorigin="anonymous"></script>
</body>
</html>
