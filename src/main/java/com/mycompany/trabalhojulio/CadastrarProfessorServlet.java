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

@WebServlet("/CadastrarProfessorServlet")
public class CadastrarProfessorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codigoIdentificacao = request.getParameter("codigoIdentificacao");
        String nomeCompleto = request.getParameter("nomeCompleto");
        String dataContratacao = request.getParameter("dataContratacao");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        String[] especializacoes = request.getParameterValues("especializacoes");

        try (Connection conn = dbconnect.getConnection()) {
            conn.setAutoCommit(false); // Iniciar transação

            // Inserir o professor na tabela 'professores'
            String insertProfessor = "INSERT INTO professores (codigo_identificacao, nome_completo, data_contratacao, telefone, email) VALUES (?, ?, ?, ?, ?) RETURNING professor_id";
            int professorId = 0;

            try (PreparedStatement stmt = conn.prepareStatement(insertProfessor)) {
                stmt.setString(1, codigoIdentificacao);
                stmt.setString(2, nomeCompleto);
                stmt.setDate(3, java.sql.Date.valueOf(dataContratacao));
                stmt.setString(4, telefone);
                stmt.setString(5, email);
                var rs = stmt.executeQuery();
                if (rs.next()) {
                    professorId = rs.getInt("professor_id");
                }
            }

            // Inserir as especializações selecionadas na tabela 'professor_especializacoes'
            if (especializacoes != null && professorId > 0) {
                String insertEspecializacao = "INSERT INTO professor_especializacoes (professor_id, especializacao_id) VALUES (?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(insertEspecializacao)) {
                    for (String especializacaoId : especializacoes) {
                        stmt.setInt(1, professorId);
                        stmt.setInt(2, Integer.parseInt(especializacaoId));
                        stmt.addBatch();
                    }
                    stmt.executeBatch();
                }
            }

            conn.commit(); // Confirmar transação
            response.getWriter().write("<script>alert('Professor cadastrado com sucesso!'); window.location.href='jsp/cad/cadprofessor.jsp';</script>");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().write("<script>alert('Erro ao cadastrar o professor.'); window.location.href='jsp/cad/cadprofessor.jsp';</script>");
        }
    }
}
