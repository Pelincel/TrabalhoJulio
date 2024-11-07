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