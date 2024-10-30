/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CadastroServlet")
public class CadastroServlet extends HttpServlet {

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // Pega os dados do formulário
    String nomeUsuario = request.getParameter("nome_usuario");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String tipoUsuario = "professor"; // Define o tipo de usuário como "professor" por padrão
    
    try (Connection connection = dbconnect.getConnection()) {
        // Cria o SQL para inserir os dados no banco
        String sql = "INSERT INTO usuarios (nome_usuario, email, senha, tipo_usuario) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, nomeUsuario);
            statement.setString(2, email);
            statement.setString(3, password);
            statement.setString(4, tipoUsuario);
            
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                response.getWriter().println("Erro ao realizar o cadastro.");
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        response.getWriter().println("Erro de conexão com o banco de dados.");
    }
}
}
