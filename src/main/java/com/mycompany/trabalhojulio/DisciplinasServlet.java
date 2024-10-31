package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/DisciplinasServlet")
public class DisciplinasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String alunoIdParam = request.getParameter("alunoId");
        System.out.println("Parâmetro alunoId recebido: " + alunoIdParam); // Log do valor recebido

        // Verifique se o parâmetro está vazio ou nulo
        if (alunoIdParam == null || alunoIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Aluno ID não pode ser vazio");
            return;
        }

        // Aqui você pode usar alunoIdParam diretamente na consulta
        ArrayList<Map<String, String>> disciplinas = new ArrayList<>();

        try (Connection conn = dbconnect.getConnection()) {
            String query = "SELECT d.nome, ad.status FROM aluno_disciplinas ad " +
                           "JOIN disciplinas d ON ad.disciplina_id = d.disciplina_id " +
                           "WHERE ad.aluno_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, alunoIdParam); // Use setString para o alunoId
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Map<String, String> disciplina = new HashMap<>();
                    disciplina.put("nomeDisciplina", rs.getString("nome"));
                    disciplina.put("status", rs.getString("status"));
                    disciplinas.add(disciplina);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(disciplinas));
        out.flush();
    }
}
