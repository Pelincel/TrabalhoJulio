package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ExcluirAlunoServlet")
public class ExcluirAlunoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String alunoIdStr = request.getParameter("alunoId");

        // Verifica se o ID foi passado corretamente
        if (alunoIdStr != null && !alunoIdStr.isEmpty()) {
            int alunoId = Integer.parseInt(alunoIdStr);

            try (Connection conn = dbconnect.getConnection()) {
                String sqlDelete = "DELETE FROM alunos WHERE aluno_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sqlDelete)) {
                    ps.setInt(1, alunoId);
                    int rowsAffected = ps.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        response.getWriter().write("<script>alert('Aluno deletado com sucesso!'); window.location.href='home.jsp';</script>");
                    } else {
                        response.getWriter().write("<script>alert('Erro ao excluir o aluno.'); window.location.href='home.jsp';</script>");
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                response.getWriter().write("<script>alert('Erro ao excluir o aluno.'); window.location.href='home.jsp';</script>");
                e.printStackTrace();
            }
        } else {
            response.getWriter().write("<script>alert('ID de aluno inválido.'); window.location.href='home.jsp';</script>");
        }
    }
}