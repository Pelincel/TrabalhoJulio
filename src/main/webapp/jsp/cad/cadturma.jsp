<%-- 
    Document   : cadturma
    Created on : 8 de nov. de 2024, 12:11:10
    Author     : Administrador
--%>

<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Turma</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
       .alert-message {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            display: none;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .alert-success { background-color: #d4edda; color: #155724; }
        .alert-error { background-color: #f8d7da; color: #721c24; } 
        
    </style>
</head>
 
<body>

    <div class="container">
        <h2 class="mt-4">Cadastrar Nova Turma</h2>
        <form action="${pageContext.request.contextPath}/CadastrarTurmaServlet" method="post">
            <div class="form-group">
                <label for="codigo">Código da Turma:</label>
                <input type="text" class="form-control" id="codigo" name="codigo" required>
            </div>
            
            <div class="form-group">
                <label for="nome">Nome da Turma:</label>
                <input type="text" class="form-control" id="nome" name="nome" required>
            </div>
            
            <div class="form-group">
                <label for="anoSemestre">Ano/Semestre:</label>
                <input type="text" class="form-control" id="anoSemestre" name="anoSemestre" required>
            </div>
            
            <div class="form-group">
                <label for="curso">Curso:</label>
                <select class="form-control" id="curso" name="curso" required>
                    <% 
                        // Conectando ao banco para listar os cursos
                        try (Connection conn = dbconnect.getConnection()) {
                            String query = "SELECT * FROM cursos";
                            try (PreparedStatement stmt = conn.prepareStatement(query);
                                 ResultSet rs = stmt.executeQuery()) {
                                while (rs.next()) {
                                    int cursoId = rs.getInt("curso_id");
                                    String nomeCurso = rs.getString("nome");
                    %>
                                    <option value="<%= cursoId %>"><%= nomeCurso %></option>
                    <%  
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Cadastrar Turma</button>
        </form>
    </div>

</body>
</html>
