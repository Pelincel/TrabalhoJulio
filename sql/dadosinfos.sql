-- Limpar todas as tabelas e reiniciar IDs
TRUNCATE TABLE 
    usuarios,
    professor_especializacoes,
    especializacoes,
    aluno_disciplinas,
    turma_disciplinas,
    curso_disciplinas,
    cursos,
    salas_aula,
    notas,
    avaliacoes,
    matriculas,
    turmas,
    disciplinas,
    professores,
    alunos 
RESTART IDENTITY CASCADE;

-- Inserindo usuários
INSERT INTO usuarios (nome_usuario, senha, email, tipo_usuario) VALUES
    ('admin', 'senha123', 'admin@escola.com', 'administrador'),
    ('professor1', 'senha123', 'professor1@escola.com', 'professor'),
    ('aluno1', 'senha123', 'aluno1@escola.com', 'aluno');

-- Inserindo alunos
INSERT INTO alunos (codigo_matricula, nome_completo, data_nascimento, endereco, telefone, email) VALUES
    ('MAT202301', 'João Silva', '2003-05-15', 'Rua A, 123', '11987654321', 'joao.silva@escola.com'),
    ('MAT202302', 'Maria Oliveira', '2004-07-20', 'Rua B, 456', '11987654322', 'maria.oliveira@escola.com'),
    ('MAT202303', 'Carlos Pereira', '2003-03-22', 'Rua C, 789', '11987654323', 'carlos.pereira@escola.com'),
    ('MAT202304', 'Larissa Costa', '2002-11-30', 'Rua D, 101', '11987654324', 'larissa.costa@escola.com'),
    ('MAT202305', 'Rafael Sousa', '2003-09-12', 'Rua E, 202', '11987654325', 'rafael.sousa@escola.com');

-- Inserindo professores
INSERT INTO professores (codigo_identificacao, nome_completo, data_contratacao, telefone, email) VALUES
    ('PROF001', 'Ana Lima', '2015-02-10', '11987654324', 'ana.lima@escola.com'),
    ('PROF002', 'Pedro Santos', '2016-03-15', '11987654325', 'pedro.santos@escola.com'),
    ('PROF003', 'Julia Ferreira', '2017-09-05', '11987654326', 'julia.ferreira@escola.com'),
    ('PROF004', 'Marcos Almeida', '2018-11-18', '11987654327', 'marcos.almeida@escola.com');

-- Inserindo especializações
INSERT INTO especializacoes (nome) VALUES
    ('Matemática'),
    ('Física'),
    ('Química'),
    ('História');

-- Inserindo professor_especializacoes
INSERT INTO professor_especializacoes (professor_id, especializacao_id) VALUES
    (1, 1),  -- Ana Lima - Matemática
    (2, 2),  -- Pedro Santos - Física
    (2, 3),  -- Pedro Santos - Química
    (3, 4),  -- Julia Ferreira - História
    (4, 1);  -- Marcos Almeida - Matemática

-- Inserindo salas de aula
INSERT INTO salas_aula (numero, capacidade_maxima) VALUES
    ('101', 30),
    ('102', 25);

-- Inserindo disciplinas
INSERT INTO disciplinas (codigo, nome, carga_horaria) VALUES
    ('MAT101', 'Matemática Básica', 60),
    ('FIS101', 'Física 1', 45),
    ('QUI101', 'Química Geral', 60),
    ('HIS101', 'História do Brasil', 40);

-- Inserindo cursos
INSERT INTO cursos (nome) VALUES
    ('Engenharia'),
    ('Ciências Exatas');

-- Inserindo curso_disciplinas
INSERT INTO curso_disciplinas (curso_id, disciplina_id) VALUES
    (1, 1),  -- Engenharia - Matemática Básica
    (1, 2),  -- Engenharia - Física 1
    (2, 3),  -- Ciências Exatas - Química Geral
    (2, 4);  -- Ciências Exatas - História do Brasil

-- Inserindo turmas
INSERT INTO turmas (codigo, nome, ano_semestre) VALUES
    ('TURMA2023A', 'Turma A', '2023.1'),
    ('TURMA2023B', 'Turma B', '2023.2');

-- Inserindo matriculas
INSERT INTO matriculas (aluno_id, turma_id, data_realizacao, status) VALUES
    (1, 1, '2023-02-01', 'ativa'),
    (2, 1, '2023-02-01', 'ativa'),
    (3, 2, '2023-08-01', 'ativa'),
    (4, 1, '2023-02-01', 'ativa'),
    (5, 2, '2023-08-01', 'ativa');

-- Criando a tabela de turma_alunos
CREATE TABLE turma_alunos (
    id SERIAL PRIMARY KEY,
    turma_id INT NOT NULL,
    aluno_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('ativa', 'trancada', 'concluída')),
    FOREIGN KEY (turma_id) REFERENCES turmas(turma_id) ON DELETE CASCADE,
    FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id) ON DELETE CASCADE
);

-- Inserindo dados na tabela turma_alunos
INSERT INTO turma_alunos (turma_id, aluno_id, status) VALUES
    (1, 1, 'ativa'),  -- João Silva na Turma A
    (1, 2, 'ativa'),  -- Maria Oliveira na Turma A
    (2, 3, 'ativa'),  -- Carlos Pereira na Turma B
    (1, 4, 'ativa'),  -- Larissa Costa na Turma A
    (2, 5, 'ativa');  -- Rafael Sousa na Turma B

-- Inserindo turma_disciplinas
INSERT INTO turma_disciplinas (turma_id, disciplina_id, professor_id, sala_id) VALUES
    (1, 1, 1, 1),  -- Turma A - Matemática Básica - Ana Lima - Sala 101
    (1, 2, 2, 2),  -- Turma A - Física 1 - Pedro Santos - Sala 102
    (2, 3, 3, 1),  -- Turma B - Química Geral - Julia Ferreira - Sala 101
    (2, 4, 4, 2);  -- Turma B - História do Brasil - Marcos Almeida - Sala 102

-- Inserindo aluno_disciplinas
INSERT INTO aluno_disciplinas (aluno_id, disciplina_id, turma_id, status) VALUES
    (1, 1, 1, 'ativa'),
    (2, 2, 1, 'ativa'),
    (3, 3, 2, 'ativa'),
    (4, 4, 1, 'ativa'),
    (5, 4, 2, 'ativa');

-- Inserindo avaliações
INSERT INTO avaliacoes (disciplina_id, descricao, data_avaliacao, peso) VALUES
    (1, 'Prova 1', '2023-03-20', 0.4),
    (2, 'Prova 2', '2023-04-15', 0.6),
    (3, 'Trabalho Final', '2023-05-30', 1.0),
    (4, 'Prova de História', '2023-06-15', 0.5);

-- Inserindo notas
INSERT INTO notas (matricula_id, avaliacao_id, nota) VALUES
    (1, 1, 8.5),  -- João Silva na Prova 1 de Matemática
    (2, 2, 9.0),  -- Maria Oliveira na Prova 2 de Física
    (3, 3, 7.5),  -- Carlos Pereira no Trabalho Final de Química
    (4, 4, 6.8),  -- Larissa Costa na Prova de História
    (5, 1, 8.0),  -- Rafael Sousa na Prova 1 de Matemática
    (2, 3, 7.9),  -- Maria Oliveira no Trabalho Final de Química
    (4, 2, 8.3),  -- Larissa Costa na Prova 2 de Física
    (5, 4, 9.5);  -- Rafael Sousa na Prova de História
