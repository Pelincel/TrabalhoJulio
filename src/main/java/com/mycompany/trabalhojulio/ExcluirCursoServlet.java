package com.mycompany.trabalhojulio;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ExcluirCursoServlet")
public class ExcluirCursoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cursoId = request.getParameter("cursoId");

        if (cursoId != null && !cursoId.isEmpty()) {
            try (Connection conn = dbconnect.getConnection()) {
                // Iniciar transação (caso haja outras tabelas dependentes)
                conn.setAutoCommit(false);
                
                // Remover curso das tabelas relacionadas, se necessário
                String deleteCursoQuery = "DELETE FROM cursos WHERE curso_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteCursoQuery)) {
                    stmt.setInt(1, Integer.parseInt(cursoId));
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        conn.commit(); // Confirmar exclusão
                        response.sendRedirect("jsp/home.jsp"); // Redireciona de volta para a lista de cursos
                    } else {
                        conn.rollback(); // Caso erro, desfaz alterações
                        response.getWriter().println("Erro ao excluir o curso.");
                    }
                } catch (SQLException e) {
                    conn.rollback();
                    e.printStackTrace();
                    response.getWriter().println("Erro ao excluir o curso: " + e.getMessage());
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Erro na conexão com o banco de dados.");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ExcluirCursoServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.getWriter().println("ID do curso não fornecido.");
        }
    }
}
