-- Limpando dados de todas as tabelas (na ordem correta devido às dependências)
TRUNCATE TABLE notas, avaliacoes, aluno_disciplinas, turma_disciplinas, curso_turmas, matriculas, alunos, professores, disciplinas, turmas, cursos, salas_aula, usuarios, especializacoes, professor_especializacoes, curso_disciplinas RESTART IDENTITY CASCADE;

-- Inserir dados em 'cursos'
INSERT INTO cursos (nome) VALUES 
('Desenvolvimento de Sistemas'),
('Edificações'),
('Eletroeletrônica'),
('Mecânica'),
('Agronegócio'),
('Enfermagem');

-- Inserir dados em 'turmas'
INSERT INTO turmas (codigo, nome, ano_semestre) VALUES 
('TDS01', 'Turma DS 2024.1', '2024.1'),
('TED01', 'Turma ED 2024.1', '2024.1'),
('TEL01', 'Turma EL 2024.1', '2024.1'),
('TME01', 'Turma ME 2024.1', '2024.1'),
('TAG01', 'Turma AG 2024.1', '2024.1'),
('TEN01', 'Turma EN 2024.1', '2024.1');

-- Inserir dados em 'curso_turmas'
INSERT INTO curso_turmas (curso_id, turma_id) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6);

-- Inserir dados em 'alunos'
INSERT INTO alunos (codigo_matricula, nome_completo, data_nascimento, endereco, telefone, email) VALUES
('A001', 'Carlos Silva', '2000-05-15', 'Rua A, 123', '1111-1111', 'carlos.silva@example.com'),
('A002', 'Mariana Souza', '2001-03-22', 'Rua B, 456', '2222-2222', 'mariana.souza@example.com'),
('A003', 'Pedro Santos', '2000-08-10', 'Rua C, 789', '3333-3333', 'pedro.santos@example.com');

-- Inserir dados em 'professores'
INSERT INTO professores (codigo_identificacao, nome_completo, data_contratacao, telefone, email) VALUES
('P001', 'João Pereira', '2015-02-10', '4444-4444', 'joao.pereira@example.com'),
('P002', 'Ana Lima', '2016-04-12', '5555-5555', 'ana.lima@example.com'),
('P003', 'Roberto Alves', '2018-06-14', '6666-6666', 'roberto.alves@example.com');

-- Inserir dados em 'disciplinas'
INSERT INTO disciplinas (codigo, nome, carga_horaria) VALUES
('DS101', 'Programação', 80),
('ED201', 'Materiais de Construção', 60),
('EE301', 'Circuitos Elétricos', 75),
('ME401', 'Mecânica dos Fluidos', 90),
('AG501', 'Gestão Rural', 70),
('EN601', 'Anatomia Humana', 85);

-- Inserir dados em 'curso_disciplinas'
INSERT INTO curso_disciplinas (curso_id, disciplina_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6);

-- Inserir dados em 'turma_disciplinas'
INSERT INTO turma_disciplinas (turma_id, disciplina_id, professor_id) VALUES
(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 1), (5, 5, 2), (6, 6, 3);

-- Inserir dados em 'salas_aula'
INSERT INTO salas_aula (numero, capacidade_maxima) VALUES
('A101', 40),
('B202', 35),
('C303', 30);

-- Inserir dados em 'matriculas'
INSERT INTO matriculas (aluno_id, turma_id, data_realizacao, status) VALUES
(1, 1, '2024-02-01', 'ativa'),
(2, 2, '2024-02-01', 'ativa'),
(3, 3, '2024-02-01', 'ativa');

-- Inserir dados em 'avaliacoes'
INSERT INTO avaliacoes (disciplina_id, descricao, data_avaliacao, peso) VALUES
(1, 'Prova 1', '2024-04-15', 3.0),
(2, 'Trabalho Final', '2024-06-10', 2.0),
(3, 'Prova 2', '2024-05-20', 4.0);

-- Inserir dados em 'notas'
INSERT INTO notas (matricula_id, avaliacao_id, nota) VALUES
(1, 1, 8.5), (2, 2, 9.0), (3, 3, 7.5);

-- Inserir dados em 'usuarios'
INSERT INTO usuarios (nome_usuario, senha, email, tipo_usuario) VALUES
('admin', 'admin123', 'admin@example.com', 'administrador'),
('professor1', 'senha123', 'joao.pereira@example.com', 'professor'),
('aluno1', 'senha123', 'carlos.silva@example.com', 'aluno');

-- Inserir dados em 'especializacoes'
INSERT INTO especializacoes (nome) VALUES 
('Engenharia de Software'), 
('Construção Civil'), 
('Eletrônica'), 
('Física Aplicada'), 
('Agronomia'), 
('Enfermagem Geral');

-- Inserir dados em 'professor_especializacoes'
INSERT INTO professor_especializacoes (professor_id, especializacao_id) VALUES
(1, 1), (2, 2), (3, 3);
