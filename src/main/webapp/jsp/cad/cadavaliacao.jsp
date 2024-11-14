<%@page import="java.sql.*" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Avaliação</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../css/header.css">
    <link rel="stylesheet" href="../../css/cadastro.css">
    <style>
        .form-container {
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            padding: 1.5rem;
        }
    </style>
</head>
<body>

<header class="py-3">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h3>CeepSystem</h3>
            <a href="../home.jsp"><img src="../../img/icons/home1.svg" /></a>
        </div>
    </div>
</header>

<div class="container mt-5">
    <div class="row">
        <!-- Coluna da esquerda: Formulário de Cadastro -->
        <div class="col-md-6">
            <div class="form-container">
                <h4 class="text-center">Cadastrar Nova Avaliação</h4>
                <form action="${pageContext.request.contextPath}/CadastrarAvaliacaoServlet" method="post">
                    
                    <!-- Seleção de Disciplina -->
                    <div class="form-group">
                        <label for="disciplina">Disciplina:</label>
                        <select class="form-control" id="disciplina" name="disciplina" required>
                            <% 
                                // Conectar ao banco e listar disciplinas
                                try (Connection conn = dbconnect.getConnection()) {
                                    String query = "SELECT disciplina_id, nome FROM disciplinas";
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

                    <!-- Descrição -->
                    <div class="form-group">
                        <label for="descricao">Descrição:</label>
                        <input type="text" class="form-control" id="descricao" name="descricao" required>
                    </div>

                    <!-- Data da Avaliação -->
                    <div class="form-group">
                        <label for="data_avaliacao">Data da Avaliação:</label>
                        <input type="date" class="form-control" id="data_avaliacao" name="data_avaliacao" required>
                    </div>

                    <!-- Peso da Avaliação -->
                    <div class="form-group">
                        <label for="peso">Peso:</label>
                        <input type="number" step="0.01" class="form-control" id="peso" name="peso" min="0" required>
                    </div>

                    <!-- Botão de Enviar -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-danger">Cadastrar Avaliação</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Coluna da direita: Lista de Avaliações -->
        <div class="col-md-6">
            <div class="form-container">
                <h4 class="text-center">Avaliações Cadastradas</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Disciplina</th>
                            <th>Descrição</th>
                            <th>Data</th>
                            <th>Peso</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            // Exibir as avaliações cadastradas
                            try (Connection conn = dbconnect.getConnection()) {
                                String query = "SELECT av.avaliacao_id, a.nome AS disciplina, av.descricao, av.data_avaliacao, av.peso " +
                                               "FROM avaliacoes av " +
                                               "JOIN disciplinas a ON av.disciplina_id = a.disciplina_id";
                                try (PreparedStatement stmt = conn.prepareStatement(query);
                                     ResultSet rs = stmt.executeQuery()) {
                                    while (rs.next()) {
                                        int avaliacaoId = rs.getInt("avaliacao_id");
                                        String disciplina = rs.getString("disciplina");
                                        String descricao = rs.getString("descricao");
                                        Date dataAvaliacao = rs.getDate("data_avaliacao");
                                        double peso = rs.getDouble("peso");
                        %>
                                        <tr>
                                            <td><%= disciplina %></td>
                                            <td><%= descricao %></td>
                                            <td><%= dataAvaliacao.toString() %></td>
                                            <td><%= peso %></td>
                                        </tr>
                        <%  
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
