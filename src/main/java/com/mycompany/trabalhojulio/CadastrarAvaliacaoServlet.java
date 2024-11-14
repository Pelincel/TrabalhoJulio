package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CadastrarAvaliacaoServlet")
public class CadastrarAvaliacaoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String descricao = request.getParameter("descricao");
        String dataAvaliacao = request.getParameter("data_avaliacao");
        String pesoStr = request.getParameter("peso");
        String disciplinaIdStr = request.getParameter("disciplina");

        try {
            int disciplinaId = Integer.parseInt(disciplinaIdStr);
            double peso = Double.parseDouble(pesoStr);

            try (Connection conn = dbconnect.getConnection()) {
                String query = "INSERT INTO avaliacoes (disciplina_id, descricao, data_avaliacao, peso) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, disciplinaId);
                    stmt.setString(2, descricao);
                    stmt.setDate(3, java.sql.Date.valueOf(dataAvaliacao));
                    stmt.setDouble(4, peso);

                    stmt.executeUpdate();
                }
            }

            // Redirecionar para uma página de sucesso ou para a listagem de avaliações
            response.sendRedirect("jsp/cad/cadavaliacao.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/cad/cadavaliacao.jsp");
        }
    }
}
