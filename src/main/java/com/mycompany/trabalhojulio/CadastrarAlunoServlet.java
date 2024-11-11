package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CadastrarAlunoServlet")
public class CadastrarAlunoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obter os parâmetros do formulário
        String matricula = request.getParameter("matricula");
        String nome = request.getParameter("nome");
        String cursoParam = request.getParameter("curso");
        String turmaParam = request.getParameter("turma");
        String endereco = request.getParameter("endereco");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        String dataNascimento = request.getParameter("data_nascimento");

        // Verificar se todos os parâmetros necessários estão presentes
        if (matricula == null || nome == null || cursoParam == null || turmaParam == null || dataNascimento == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dados incompletos no formulário");
            return;
        }

        try {
            int cursoId = Integer.parseInt(cursoParam);
            int turmaId = Integer.parseInt(turmaParam);
            LocalDate dataAtual = LocalDate.now(); // Obter a data atual

            try (Connection conn = dbconnect.getConnection()) {
                // Inserir o aluno na tabela "alunos"
                String queryAluno = "INSERT INTO alunos (codigo_matricula, nome_completo, endereco, telefone, email, data_nascimento) " +
                                    "VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmtAluno = conn.prepareStatement(queryAluno, Statement.RETURN_GENERATED_KEYS)) {
                    stmtAluno.setString(1, matricula);
                    stmtAluno.setString(2, nome);
                    stmtAluno.setString(3, endereco);
                    stmtAluno.setString(4, telefone);
                    stmtAluno.setString(5, email);
                    stmtAluno.setDate(6, Date.valueOf(dataNascimento));
                    stmtAluno.executeUpdate();

                    // Obter o ID do aluno recém-cadastrado
                    ResultSet rsAluno = stmtAluno.getGeneratedKeys();
                    if (rsAluno.next()) {
                        int alunoId = rsAluno.getInt(1);

                        // Inserir na tabela "matriculas"
                        String queryMatricula = "INSERT INTO matriculas (aluno_id, turma_id, curso_id, data_realizacao, status) " +
                                                "VALUES (?, ?, ?, ?, 'ativa')";
                        try (PreparedStatement stmtMatricula = conn.prepareStatement(queryMatricula)) {
                            stmtMatricula.setInt(1, alunoId);
                            stmtMatricula.setInt(2, turmaId);
                            stmtMatricula.setInt(3, cursoId);
                            stmtMatricula.setDate(4, Date.valueOf(dataAtual)); // Usar a data atual
                            stmtMatricula.executeUpdate();
                        }
                    }
                }

                // Redirecionar para a página home após o sucesso
                response.sendRedirect("jsp/home.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao inserir no banco de dados: " + e.getMessage());
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Erro ao converter parâmetros para números");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Driver do banco de dados não encontrado");
        }
    }
}
