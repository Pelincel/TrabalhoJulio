<%-- 
    Document   : cadespecializacao
    Created on : 8 de nov. de 2024, 19:00:21
    Author     : silva
--%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Especializações</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/header.css">
    <style>
        /* Adicionando estilo para a tabela com rolagem */
        .scroll-table {
            max-height: 300px; /* Altura máxima da tabela */
            overflow-y: auto;  /* Adiciona a barra de rolagem vertical */
        }
        .scroll-table table {
            width: 100%;
            border-collapse: collapse;
        }
        .scroll-table th, .scroll-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <header class="py-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h3>CeepSystem</h3>
                <a href="home.jsp"><img src="../../img/icons/home1.svg" /></a>
            </div>
        </div>
    </header>

    <div class="container mt-5">
        <h4>Cadastro de Especializações</h4>
        
        <!-- Formulário para cadastrar especialização -->
        <form action="${pageContext.request.contextPath}/CadastrarEspecializacaoServlet" method="post" class="mb-4">
            <div class="form-group">
                <label for="nomeEspecializacao">Nome da Especialização:</label>
                <input type="text" name="nomeEspecializacao" id="nomeEspecializacao" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Cadastrar</button>
        </form>

        <hr>

        <h5>Especializações Cadastradas</h5>
        <!-- Tabela com barra de rolagem -->
        <div class="scroll-table">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Carregar especializações do banco de dados
                        try (Connection conn = dbconnect.getConnection()) {
                            String query = "SELECT especializacao_id, nome FROM especializacoes";
                            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("especializacao_id") %></td>
                        <td><%= rs.getString("nome") %></td>
                    </tr>
                    <%
                                }
                            }
                        } catch (SQLException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
