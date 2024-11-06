/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.trabalhojulio;

import com.mycompany.trabalhojulio.dbconnect.dbconnect;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;

/**
 *
 * @author silva
 */
@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> cursos = new ArrayList<>();
        List<Integer> alunosPorCurso = new ArrayList<>();

        try {
            // Usando a classe dbconnect para obter a conexão
            conn = dbconnect.getConnection();

            // Consulta SQL
            String sql = "SELECT c.nome AS curso, COUNT(m.aluno_id) AS total_alunos\n" +
"FROM cursos c\n" +
"JOIN curso_disciplinas cd ON c.curso_id = cd.curso_id\n" +
"JOIN disciplinas d ON cd.disciplina_id = d.disciplina_id\n" +
"JOIN turma_disciplinas td ON d.disciplina_id = td.disciplina_id\n" +
"JOIN turmas t ON td.turma_id = t.turma_id\n" +
"LEFT JOIN matriculas m ON t.turma_id = m.turma_id\n" +
"GROUP BY c.curso_id;";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            // Preenchendo as listas com os dados retornados
            while (rs.next()) {
                cursos.add(rs.getString("curso"));
                alunosPorCurso.add(rs.getInt("total_alunos"));
            }

            Gson gson = new Gson();
String cursosJson = gson.toJson(cursos);
String alunosPorCursoJson = gson.toJson(alunosPorCurso);

// Passando os dados para a JSP como JSON
request.setAttribute("cursos", cursosJson);
request.setAttribute("alunosPorCurso", alunosPorCursoJson);

            // Passando os dados para a JSP
            request.setAttribute("cursos", cursos);
            request.setAttribute("alunosPorCurso", alunosPorCurso);
            
            // Redirecionando para a JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Fechar a conexão e os objetos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    
}
