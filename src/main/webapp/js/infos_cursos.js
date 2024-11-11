        document.addEventListener('DOMContentLoaded', function() {
            const buttons = document.querySelectorAll('.ver-alunos');
            buttons.forEach(button => {
                button.addEventListener('click', function() {
                    const turmaId = this.getAttribute('data-turma-id');
                    const alunosContainer = document.getElementById('alunos-container');

                    // Verifica se já está exibindo os alunos para essa turma
                    if (alunosContainer.style.display === 'block' && alunosContainer.dataset.turmaId === turmaId) {
                        alunosContainer.style.display = 'none'; // Esconde se estiver visível
                        alunosContainer.innerHTML = ''; // Limpa o conteúdo
                    } else {
                        loadAlunos(turmaId);
                    }
                });
            });
        });

        function loadAlunos(turmaId) {
            const alunosContainer = document.getElementById('alunos-container');
            alunosContainer.innerHTML = ''; // Limpar conteúdo anterior
            alunosContainer.dataset.turmaId = turmaId; // Armazena o ID da turma

            fetch('functions/buscar_alunos.jsp?turma_id=' + turmaId)
                .then(response => response.text())
                .then(data => {
                    alunosContainer.innerHTML = data;
                    alunosContainer.style.display = 'block'; // Exibir a lista de alunos
                })
                .catch(error => {
                    console.error('Erro ao carregar alunos:', error);
                });
        }