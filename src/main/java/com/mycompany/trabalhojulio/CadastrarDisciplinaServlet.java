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

@WebServlet("/CadastrarDisciplinaServlet")
public class CadastrarDisciplinaServlet extends jakarta.servlet.http.HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws ServletException, IOException {
        // Obtendo os dados do formulário
        String codigo = request.getParameter("codigo");
        String nome = request.getParameter("nome");
        int cargaHoraria = Integer.parseInt(request.getParameter("carga_horaria"));

        String errorMessage = "";

        try (Connection conn = dbconnect.getConnection()) {
            // SQL para inserir a nova disciplina
            String query = "INSERT INTO disciplinas (codigo, nome, carga_horaria) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, codigo);
                stmt.setString(2, nome);
                stmt.setInt(3, cargaHoraria);

                // Executando o comando de inserção
                int rowsAffected = stmt.executeUpdate();

                // Verificando se a disciplina foi inserida com sucesso
                if (rowsAffected > 0) {
                    // Envia um alert de sucesso e redireciona para home.jsp
                    response.setContentType("text/html");
                    response.getWriter().println("<script type=\"text/javascript\">");
                    response.getWriter().println("alert('Disciplina cadastrada com sucesso!');");
                    response.getWriter().println("window.location.href = 'jsp/home.jsp';");
                    response.getWriter().println("</script>");
                } else {
                    errorMessage = "Erro ao cadastrar a disciplina.";
                    request.setAttribute("errorMessage", errorMessage);
                    request.getRequestDispatcher("jsp/cad/caddisciplina.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            errorMessage = "Erro ao conectar com o banco de dados: " + e.getMessage();
            e.printStackTrace();
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("jsp/cad/caddisciplina.jsp").forward(request, response);
        }
    }
}
