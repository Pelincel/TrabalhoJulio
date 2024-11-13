-- 1. Tabela de Cursos
CREATE TABLE cursos (
    curso_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- 2. Tabela de Alunos
CREATE TABLE alunos (
    aluno_id SERIAL PRIMARY KEY,
    codigo_matricula VARCHAR(20) UNIQUE NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco TEXT,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- 3. Tabela de Professores
CREATE TABLE professores (
    professor_id SERIAL PRIMARY KEY,
    codigo_identificacao VARCHAR(20) UNIQUE NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    data_contratacao DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- 4. Tabela de Especializações
CREATE TABLE especializacoes (
    especializacao_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);

-- 5. Tabela de Professor-Especializações (M:N)
CREATE TABLE professor_especializacoes (
    professor_id INT NOT NULL,
    especializacao_id INT NOT NULL,
    PRIMARY KEY (professor_id, especializacao_id),
    FOREIGN KEY (professor_id) REFERENCES professores(professor_id) ON DELETE CASCADE,
    FOREIGN KEY (especializacao_id) REFERENCES especializacoes(especializacao_id) ON DELETE CASCADE
);

-- 6. Tabela de Disciplinas
CREATE TABLE disciplinas (
    disciplina_id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL
);

-- 7. Tabela de Salas de Aula
CREATE TABLE salas_aula (
    sala_id SERIAL PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    capacidade_maxima INT NOT NULL CHECK (capacidade_maxima > 0)
);

-- 8. Tabela de Turmas
CREATE TABLE turmas (
    turma_id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    ano_semestre VARCHAR(10) NOT NULL
);

-- 9. Tabela de Cursos e Turmas (M:N)
CREATE TABLE curso_turmas (
    curso_id INT NOT NULL,
    turma_id INT NOT NULL,
    PRIMARY KEY (curso_id, turma_id),
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE,
    FOREIGN KEY (turma_id) REFERENCES turmas(turma_id) ON DELETE CASCADE
);

-- 10. Tabela de Disciplinas dos Cursos (M:N)
CREATE TABLE curso_disciplinas (
    curso_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    PRIMARY KEY (curso_id, disciplina_id),
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(disciplina_id) ON DELETE CASCADE
);

-- 11. Tabela de Disciplinas das Turmas (M:N)
CREATE TABLE turma_disciplinas (
    turma_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    professor_id INT NOT NULL,
    sala_id INT,
    PRIMARY KEY (turma_id, disciplina_id, professor_id),
    FOREIGN KEY (turma_id) REFERENCES turmas(turma_id) ON DELETE CASCADE,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(disciplina_id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES professores(professor_id) ON DELETE SET NULL,
    FOREIGN KEY (sala_id) REFERENCES salas_aula(sala_id) ON DELETE SET NULL
);

-- 12. Tabela de Matrículas
CREATE TABLE matriculas (
    matricula_id SERIAL PRIMARY KEY,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    curso_id INT NOT NULL,
    data_realizacao DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('ativa', 'trancada', 'concluída')),
    FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id) ON DELETE CASCADE,
    FOREIGN KEY (turma_id) REFERENCES turmas(turma_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id) ON DELETE CASCADE
);

-- 13. Tabela de Avaliações
CREATE TABLE avaliacoes (
    avaliacao_id SERIAL PRIMARY KEY,
    disciplina_id INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    data_avaliacao DATE NOT NULL,
    peso NUMERIC(5, 2) CHECK (peso >= 0),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(disciplina_id) ON DELETE CASCADE
);

-- 14. Tabela de Notas por Avaliação
CREATE TABLE notas (
    nota_id SERIAL PRIMARY KEY,
    matricula_id INT NOT NULL,
    avaliacao_id INT NOT NULL,
    nota NUMERIC(5, 2) CHECK (nota >= 0 AND nota <= 10),
    FOREIGN KEY (matricula_id) REFERENCES matriculas(matricula_id) ON DELETE CASCADE,
    FOREIGN KEY (avaliacao_id) REFERENCES avaliacoes(avaliacao_id) ON DELETE CASCADE
);

-- 15. Tabela de Disciplinas do Aluno (M:N)
CREATE TABLE aluno_disciplinas (
    aluno_disciplina_id SERIAL PRIMARY KEY,
    aluno_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    turma_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('ativa', 'trancada', 'concluída')),
    FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id) ON DELETE CASCADE,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(disciplina_id) ON DELETE CASCADE,
    FOREIGN KEY (turma_id) REFERENCES turmas(turma_id) ON DELETE CASCADE
);

-- 16. Tabela de Usuários
CREATE TABLE usuarios (
    usuario_id SERIAL PRIMARY KEY,
    nome_usuario VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_usuario VARCHAR(20) CHECK (tipo_usuario IN ('administrador', 'professor', 'aluno')) NOT NULL
);
