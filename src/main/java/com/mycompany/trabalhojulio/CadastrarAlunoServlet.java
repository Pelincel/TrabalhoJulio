package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import jakarta.servlet.Servlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/CadastrarAlunoServlet")
public class CadastrarAlunoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera os dados do formulário
        String codigoMatricula = request.getParameter("codigo_matricula");
        String nomeCompleto = request.getParameter("nome_completo");
        String dataNascimento = request.getParameter("data_nascimento");
        String endereco = request.getParameter("endereco");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");

        // Converte a string dataNascimento para o tipo java.sql.Date
        Date dataNascimentoSql = null;
        if (dataNascimento != null && !dataNascimento.isEmpty()) {
            try {
                dataNascimentoSql = Date.valueOf(dataNascimento);  // Converte a string para Date no formato YYYY-MM-DD
            } catch (IllegalArgumentException e) {
                enviarMensagem(response, "Data de nascimento inválida. Use o formato YYYY-MM-DD.");
                return;
            }
        }

        // Conectar ao banco de dados
        Connection con = null;
        try {
            con = dbconnect.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            enviarMensagem(response, "Erro ao conectar ao banco de dados. Tente novamente.");
            return;
        }

        // Verifica se a matrícula já existe
        String sqlVerificaMatricula = "SELECT COUNT(*) FROM alunos WHERE codigo_matricula = ?";
        try (PreparedStatement psVerifica = con.prepareStatement(sqlVerificaMatricula)) {
            psVerifica.setString(1, codigoMatricula);
            ResultSet rs = psVerifica.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Se a matrícula já existe, retorna um alerta e redireciona
                enviarMensagem(response, "Matrícula já existe. Tente um número diferente.");
                return;
            }
        } catch (SQLException e) {
            enviarMensagem(response, "Erro ao verificar matrícula. Tente novamente.");
            return;
        }

        // Realiza o cadastro do aluno
        String sqlCadastro = "INSERT INTO alunos (codigo_matricula, nome_completo, data_nascimento, endereco, telefone, email) "
                           + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sqlCadastro)) {
            ps.setString(1, codigoMatricula);
            ps.setString(2, nomeCompleto);
            ps.setDate(3, dataNascimentoSql);  // Aqui, passamos o tipo Date para o banco de dados
            ps.setString(4, endereco);
            ps.setString(5, telefone);
            ps.setString(6, email);

            int result = ps.executeUpdate();
            if (result > 0) {
                enviarMensagem(response, "Cadastro realizado com sucesso!");
            } else {
                enviarMensagem(response, "Erro ao realizar o cadastro. Tente novamente.");
            }
        } catch (SQLException e) {
            enviarMensagem(response, "Erro ao realizar o cadastro. Tente novamente.");
        }
    }

    // Função para enviar a mensagem com alert usando JavaScript e redirecionar para a página de cadastro
    private void enviarMensagem(HttpServletResponse response, String mensagem) throws IOException {
        response.setContentType("text/html");
        response.getWriter().write("<html><head><title>Resultado</title></head><body>");
        response.getWriter().write("<script type='text/javascript'>");
        response.getWriter().write("alert('" + mensagem + "');");
        response.getWriter().write("window.location.href = 'jsp/cadaluno.jsp';");  // Redireciona para a página de cadastro
        response.getWriter().write("</script>");
        response.getWriter().write("</body></html>");
    }
}