/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

/**
 *
 * @author Administrador
 */
@WebServlet("/DisciplinasServlet")
public class DisciplinasServlet extends HttpServlet {
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int alunoId = Integer.parseInt(request.getParameter("alunoId"));
        ArrayList<Map<String, String>> disciplinas = new ArrayList<>();

        try (Connection conn = dbconnect.getConnection()) {
            String query = "SELECT d.nome, ad.status FROM aluno_disciplinas ad " +
                           "JOIN disciplinas d ON ad.disciplina_id = d.disciplina_id " +
                           "WHERE ad.aluno_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, alunoId);
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
