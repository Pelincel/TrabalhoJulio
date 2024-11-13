ALTER TABLE curso_turmas DROP CONSTRAINT curso_turmas_turma_id_fkey;
ALTER TABLE curso_turmas DROP CONSTRAINT curso_turmas_curso_id_fkey;

DROP TABLE alunos, avaliacoes, curso_disciplinas, cursos, disciplinas, especializacoes, matriculas, notas, professor_especializacoes, professores, salas_aula, turma_alunos, turma_disciplinas, turmas, usuarios, curso_turmas;
