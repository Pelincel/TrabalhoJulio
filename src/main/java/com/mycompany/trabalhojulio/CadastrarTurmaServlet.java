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

@WebServlet("/CadastrarTurmaServlet")
public class CadastrarTurmaServlet extends jakarta.servlet.http.HttpServlet {

    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws ServletException, IOException {
        String codigo = request.getParameter("codigo");
        String nome = request.getParameter("nome");
        String anoSemestre = request.getParameter("anoSemestre");
        int cursoId = Integer.parseInt(request.getParameter("curso"));

        String errorMessage = "";

        // Inserir a turma no banco de dados
        try (Connection conn = dbconnect.getConnection()) {
            // Inserir turma na tabela de turmas
            String queryTurma = "INSERT INTO turmas (codigo, nome, ano_semestre) VALUES (?, ?, ?)";
            try (PreparedStatement stmtTurma = conn.prepareStatement(queryTurma, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmtTurma.setString(1, codigo);
                stmtTurma.setString(2, nome);
                stmtTurma.setString(3, anoSemestre);
                int rowsTurma = stmtTurma.executeUpdate();

                // Se a turma foi inserida com sucesso, associar o curso
                if (rowsTurma > 0) {
                    // Recuperando o ID da turma inserida
                    try (var rs = stmtTurma.getGeneratedKeys()) {
                        if (rs.next()) {
                            int turmaId = rs.getInt(1); // ID gerado da turma

                            // Associando o curso à turma
                            String queryCursoTurma = "UPDATE turmas SET curso_id = ? WHERE turma_id = ?";
                            try (PreparedStatement stmtCursoTurma = conn.prepareStatement(queryCursoTurma)) {
                                stmtCursoTurma.setInt(1, cursoId);
                                stmtCursoTurma.setInt(2, turmaId);
                                stmtCursoTurma.executeUpdate();
                            }

                            // Se tudo deu certo, exibe o alert de sucesso e redireciona para home.jsp
                            response.setContentType("text/html");
                            response.getWriter().println("<script type=\"text/javascript\">");
                            response.getWriter().println("alert('Turma cadastrada com sucesso!');");
                            response.getWriter().println("window.location.href = 'home.jsp';");
                            response.getWriter().println("</script>");
                        }
                    }
                } else {
                    errorMessage = "Erro ao cadastrar a turma.";
                    request.setAttribute("errorMessage", errorMessage);
                    request.getRequestDispatcher("jsp/cad/cadturma.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            errorMessage = "Erro ao conectar com o banco de dados: " + e.getMessage();
            e.printStackTrace();
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("jsp/cad/cadturma.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CadastrarTurmaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
