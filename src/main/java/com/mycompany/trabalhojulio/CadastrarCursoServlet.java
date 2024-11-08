/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/CadastrarCursoServlet")
public class CadastrarCursoServlet extends jakarta.servlet.http.HttpServlet {

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws ServletException, IOException {
        String nomeCurso = request.getParameter("nome");
        String[] disciplinasSelecionadas = request.getParameterValues("disciplinas[]");

        String errorMessage = "";

        // Inserir o curso no banco de dados
        try (Connection conn = dbconnect.getConnection()) {
            // Inserir curso na tabela de cursos
            String queryCurso = "INSERT INTO cursos (nome) VALUES (?)";
            try (PreparedStatement stmtCurso = conn.prepareStatement(queryCurso, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmtCurso.setString(1, nomeCurso);
                int rowsCurso = stmtCurso.executeUpdate();

                // Se o curso foi inserido com sucesso, associar as disciplinas
                if (rowsCurso > 0) {
                    // Recuperando o ID do curso inserido
                    try (var rs = stmtCurso.getGeneratedKeys()) {
                        if (rs.next()) {
                            int cursoId = rs.getInt(1); // ID gerado do curso

                            // Associando as disciplinas ao curso
                            if (disciplinasSelecionadas != null) {
                                String queryDisciplinaCurso = "INSERT INTO curso_disciplinas (curso_id, disciplina_id) VALUES (?, ?)";
                                try (PreparedStatement stmtDisciplina = conn.prepareStatement(queryDisciplinaCurso)) {
                                    for (String disciplinaId : disciplinasSelecionadas) {
                                        stmtDisciplina.setInt(1, cursoId);
                                        stmtDisciplina.setInt(2, Integer.parseInt(disciplinaId));
                                        stmtDisciplina.addBatch(); // Adicionando a disciplina ao batch
                                    }
                                    stmtDisciplina.executeBatch(); // Executando o batch de inserções
                                }
                            }

                            // Se tudo deu certo, exibe o alert de sucesso e redireciona para home.jsp
                            response.setContentType("text/html");
                            response.getWriter().println("<script type=\"text/javascript\">");
                            response.getWriter().println("alert('Curso cadastrado com sucesso!');");
                            response.getWriter().println("window.location.href = 'jsp/home.jsp';");
                            response.getWriter().println("</script>");
                        }
                    }
                } else {
                    errorMessage = "Erro ao cadastrar o curso.";
                    request.setAttribute("errorMessage", errorMessage);
                    request.getRequestDispatcher("/cadastrarCurso.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            errorMessage = "Erro ao conectar com o banco de dados: " + e.getMessage();
            e.printStackTrace();
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("jsp/cad/cadcurso.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CadastrarCursoServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
