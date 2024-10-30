/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author silva
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try (Connection connection = dbconnect.getConnection()) {
            // SQL para verificar o usuário e senha
            String sql = "SELECT usuario_id, nome_usuario, tipo_usuario FROM usuarios WHERE email = ? AND senha = ?";
            
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                statement.setString(2, password);
                
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Login bem-sucedido
                        int usuarioId = resultSet.getInt("usuario_id");
                        String nomeUsuario = resultSet.getString("nome_usuario");
                        String tipoUsuario = resultSet.getString("tipo_usuario");
                        
                        // Cria uma sessão e armazena os dados do usuário
                        HttpSession session = request.getSession();
                        session.setAttribute("usuarioId", usuarioId);
                        session.setAttribute("nomeUsuario", nomeUsuario);
                        session.setAttribute("tipoUsuario", tipoUsuario);
                        
                   
response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");

                    } else {
                        // Credenciais inválidas
                        request.setAttribute("errorMessage", "E-mail ou senha incorretos.");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Erro de conexão com o banco de dados.");
        }
    }
}
