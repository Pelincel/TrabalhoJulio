<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>



<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css"> <!-- Link to your custom CSS -->
    <title>Disciplinas do Aluno</title>
</head>
<body>
    <header class="bg-primary text-white py-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3">Disciplinas do Aluno</h1>
                <a href="home.jsp" class="btn btn-light">Voltar</a>
            </div>
        </div>
    </header>

    <div class="container mt-4">
        <%
            int alunoId = Integer.parseInt(request.getParameter("alunoId"));
            String alunoNome = "";
            ArrayList<Map<String, String>> disciplinas = new ArrayList<>();

            try (Connection conn = dbconnect.getConnection()) {
                // Busca o nome do aluno
                String alunoQuery = "SELECT nome_completo FROM alunos WHERE aluno_id = ?";
                try (PreparedStatement alunoStmt = conn.prepareStatement(alunoQuery)) {
                    alunoStmt.setInt(1, alunoId);
                    ResultSet alunoRs = alunoStmt.executeQuery();

                    if (alunoRs.next()) {
                        alunoNome = alunoRs.getString("nome_completo");
                    }
                }

                // Busca as disciplinas do aluno e soma as notas
                String disciplinasQuery = "SELECT d.nome, ad.status, SUM(n.nota) AS total_nota " +
                                          "FROM aluno_disciplinas ad " +
                                          "JOIN disciplinas d ON ad.disciplina_id = d.disciplina_id " +
                                          "LEFT JOIN notas n ON ad.aluno_id = ? AND n.matricula_id = ( " +
                                          "   SELECT m.matricula_id FROM matriculas m WHERE m.aluno_id = ad.aluno_id AND m.turma_id = ad.turma_id " +
                                          ") " +
                                          "WHERE ad.aluno_id = ? " +
                                          "GROUP BY d.nome, ad.status";
                try (PreparedStatement disciplinasStmt = conn.prepareStatement(disciplinasQuery)) {
                    disciplinasStmt.setInt(1, alunoId);
                    disciplinasStmt.setInt(2, alunoId);
                    ResultSet disciplinasRs = disciplinasStmt.executeQuery();

                    while (disciplinasRs.next()) {
                        Map<String, String> disciplina = new HashMap<>();
                        disciplina.put("nomeDisciplina", disciplinasRs.getString("nome"));
                        disciplina.put("status", disciplinasRs.getString("status"));
                        disciplina.put("nota", disciplinasRs.getString("total_nota") != null ? disciplinasRs.getString("total_nota") : "N/A");
                        disciplinas.add(disciplina);
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>

        <h4>Disciplinas de: <%= alunoNome %></h4>
        
        <div class="info-div mt-4 p-3 border rounded shadow-sm" style="background-color: #ffffff;">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Disciplina</th>
                        <th>Status</th>
                        <th>Nota</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map<String, String> disciplina : disciplinas) {
                    %>
                    <tr>
                        <td><%= disciplina.get("nomeDisciplina") %></td>
                        <td><%= disciplina.get("status") %></td>
                        <td><%= disciplina.get("nota") %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <%
                if (disciplinas.isEmpty()) {
                    out.println("<p>Nenhuma disciplina encontrada para este aluno.</p>");
                }
            %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
