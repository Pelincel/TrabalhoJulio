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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CadalunoServlet")
public class CadalunoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera os dados do formulário
        String nomeCompleto = request.getParameter("nome_completo");
        String dataNascimento = request.getParameter("data_nascimento");
        String endereco = request.getParameter("endereco");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");

        // Gera o código de matrícula
        String codigoMatricula = null;
        try {
            codigoMatricula = gerarCodigoMatricula();
        } catch (SQLException ex) {
            Logger.getLogger(CadalunoServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CadalunoServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Conectar ao banco de dados
        Connection con = null;
        try {
            con = dbconnect.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CadalunoServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String sql = "INSERT INTO alunos (codigo_matricula, nome_completo, data_nascimento, endereco, telefone, email) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, codigoMatricula);
            ps.setString(2, nomeCompleto);
            ps.setString(3, dataNascimento);
            ps.setString(4, endereco);
            ps.setString(5, telefone);
            ps.setString(6, email);

            // Executa a inserção
            int result = ps.executeUpdate();
            if (result > 0) {
                // Redireciona para uma página de sucesso
                response.sendRedirect("sucesso.jsp");
            } else {
                response.sendRedirect("erro.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }

    // Função para gerar o código de matrícula
    private String gerarCodigoMatricula() throws SQLException, ClassNotFoundException {
        String anoCorrente = String.valueOf(java.time.LocalDate.now().getYear()); // Ano corrente
        String sequencia = "001"; // Valor inicial da sequência
        Connection con = dbconnect.getConnection();
        String sql = "SELECT codigo_matricula FROM alunos ORDER BY aluno_id DESC LIMIT 1"; // Pega o último código
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String ultimoCodigo = rs.getString("codigo_matricula");
                if (ultimoCodigo != null && ultimoCodigo.length() >= 7) {
                    String sequencialAtual = ultimoCodigo.substring(7); // Extrai a sequência numérica
                    int sequenciaInt = Integer.parseInt(sequencialAtual) + 1; // Incrementa a sequência
                    sequencia = String.format("%03d", sequenciaInt); // Formata a sequência com 3 dígitos
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "MAT" + anoCorrente + sequencia; // Monta o código de matrícula
    }
}

