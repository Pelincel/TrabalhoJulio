<%-- 
    Document   : cadastrarProfessor
    Created on : 8 de nov. de 2024, 08:33:12
    Author     : Administrador
--%>

<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Professor</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Cadastrar Professor</h2>
        <form action="${pageContext.request.contextPath}/CadastrarProfessorServlet" method="post">
            <div class="mb-3">
                <label for="codigoIdentificacao" class="form-label">Código de Identificação:</label>
                <input type="text" class="form-control" id="codigoIdentificacao" name="codigoIdentificacao" required>
            </div>
            <div class="mb-3">
                <label for="nomeCompleto" class="form-label">Nome Completo:</label>
                <input type="text" class="form-control" id="nomeCompleto" name="nomeCompleto" required>
            </div>
            <div class="mb-3">
                <label for="dataContratacao" class="form-label">Data de Contratação:</label>
                <input type="date" class="form-control" id="dataContratacao" name="dataContratacao" required>
            </div>
            <div class="mb-3">
                <label for="telefone" class="form-label">Telefone:</label>
                <input type="text" class="form-control" id="telefone" name="telefone">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" id="email" name="email">
            </div>
            
            <!-- Seleção de Especializações -->
            <div class="mb-3">
                <label for="especializacoes" class="form-label">Especializações:</label>
                <select class="form-select" id="especializacoes" name="especializacoes" multiple>
                    <%
                        // Conectar ao banco e buscar as especializações
                        try (Connection conn = dbconnect.getConnection()) {
                            String query = "SELECT especializacao_id, nome FROM especializacoes";
                            try (PreparedStatement stmt = conn.prepareStatement(query);
                                 ResultSet rs = stmt.executeQuery()) {
                                while (rs.next()) {
                                    int id = rs.getInt("especializacao_id");
                                    String nome = rs.getString("nome");
                    %>
                        <option value="<%= id %>"><%= nome %></option>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            out.println("<p>Erro ao carregar especializações.</p>");
                        }
                    %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Cadastrar</button>
        </form>
    </div>
</body>
</html>

