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
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/disciplinas.css">
    <title>Disciplinas do Aluno</title>
</head>
<body>
    
      <header class="py-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h3>CeepSystem</h3>
                <a href="home.jsp"><img src="../img/icons/home1.svg" /></a>
            </div>
        </div>
    </header>
    <div class="container mt-4">
        <%
            int alunoId = Integer.parseInt(request.getParameter("alunoId"));
            String alunoNome = "";
            String cursoNome = "";
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

                // Busca o curso associado ao aluno pela tabela de matrículas
                String cursoQuery = 
                    "SELECT c.curso_id, c.nome " +
                    "FROM cursos c " +
                    "JOIN matriculas m ON c.curso_id = m.curso_id " +
                    "WHERE m.aluno_id = ? LIMIT 1";

                int cursoId = 0;
                try (PreparedStatement cursoStmt = conn.prepareStatement(cursoQuery)) {
                    cursoStmt.setInt(1, alunoId);
                    ResultSet cursoRs = cursoStmt.executeQuery();
                    if (cursoRs.next()) {
                        cursoId = cursoRs.getInt("curso_id");
                        cursoNome = cursoRs.getString("nome");
                    }
                }

                // Busca as disciplinas associadas ao curso e notas do aluno
               String disciplinasQuery = 
    "SELECT d.nome AS disciplina, " +
    "COALESCE(SUM(n.nota), 0) AS total_nota " +
    "FROM curso_disciplinas cd " +
    "JOIN disciplinas d ON cd.disciplina_id = d.disciplina_id " +
    "LEFT JOIN notas n ON n.matricula_id = (SELECT m.matricula_id FROM matriculas m WHERE m.aluno_id = ? AND m.curso_id = ?) " +
    "AND n.avaliacao_id IN (SELECT a.avaliacao_id FROM avaliacoes a WHERE a.disciplina_id = d.disciplina_id) " +
    "WHERE cd.curso_id = ? " +
    "GROUP BY d.nome";



                try (PreparedStatement disciplinasStmt = conn.prepareStatement(disciplinasQuery)) {
    disciplinasStmt.setInt(1, alunoId);
    disciplinasStmt.setInt(2, cursoId);
    disciplinasStmt.setInt(3, cursoId);
    ResultSet disciplinasRs = disciplinasStmt.executeQuery();

    while (disciplinasRs.next()) {
        Map<String, String> disciplina = new HashMap<>();
        disciplina.put("nomeDisciplina", disciplinasRs.getString("disciplina"));
        disciplina.put("nota", disciplinasRs.getString("total_nota"));
        disciplinas.add(disciplina);
    }
}

            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>

        <h4>Disciplinas de: <%= alunoNome %></h4>
        <h5>Curso: <%= cursoNome != null && !cursoNome.isEmpty() ? cursoNome : "Não encontrado" %></h5>

    <div class="info-div mt-4 p-3 border rounded shadow-sm" style="background-color: #ffffff;">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Disciplina</th>
                <th>Nota</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Map<String, String> disciplina : disciplinas) {
            %>
            <tr>
                <td><%= disciplina.get("nomeDisciplina") %></td>
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

</body>
</html>
