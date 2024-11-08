<%-- 
    Document   : cadcurso
    Created on : 8 de nov. de 2024, 11:09:08
    Author     : Administrador
--%>

<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Curso</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="mt-4">Cadastrar Novo Curso</h2>
        <form action="${pageContext.request.contextPath}/CadastrarCursoServlet" method="post">
            <div class="form-group">
                <label for="nome">Nome do Curso:</label>
                <input type="text" class="form-control" id="nome" name="nome" required>
            </div>
            
            <div class="form-group">
                <label for="disciplinas">Disciplinas do Curso:</label>
                <select multiple class="form-control" id="disciplinas" name="disciplinas[]" required>
                    <% 
                        // Conectando ao banco para listar as disciplinas
                        try (Connection conn = dbconnect.getConnection()) {
                            String query = "SELECT * FROM disciplinas";
                            try (PreparedStatement stmt = conn.prepareStatement(query);
                                 ResultSet rs = stmt.executeQuery()) {
                                while (rs.next()) {
                                    int disciplinaId = rs.getInt("disciplina_id");
                                    String nomeDisciplina = rs.getString("nome");
                    %>
                                    <option value="<%= disciplinaId %>"><%= nomeDisciplina %></option>
                    <%  
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Cadastrar Curso</button>
        </form>
    </div>
</body>
</html>

