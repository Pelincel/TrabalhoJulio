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
    <link rel="stylesheet" href="../../css/header.css">
    <link rel="stylesheet" href="../../css/cadastro.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .medium-input {
            text-align: center;
        }
        .search-input {
            margin-bottom: 10px;
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
    <div class="form-container">
        <h4 class="text-center">Cadastrar Novo Curso</h4>
        <form action="${pageContext.request.contextPath}/CadastrarCursoServlet" method="post">
            
            <!-- Nome do Curso -->
            <div class="form-group">
                <label for="nome">Nome do Curso:</label>
                <input type="text" class="form-control medium-input" id="nome" name="nome" required>
            </div>
            
            <!-- Barra de Pesquisa e Seleção de Disciplinas -->
            <div class="form-group">
                <label for="disciplinas">Disciplinas do Curso:</label>
                
                <!-- Barra de pesquisa -->
                <input type="text" class="form-control search-input" id="searchBar" placeholder="Pesquisar disciplinas..." onkeyup="filterDisciplinas()">
                
                <!-- Seleção de disciplinas -->
                <select multiple class="form-control medium-input" id="disciplinas" name="disciplinas[]" size="6" required>
                    <% 
                        // Carregar disciplinas do banco de dados
                        try (Connection conn = dbconnect.getConnection()) {
                            String query = "SELECT * FROM disciplinas";
                            try (PreparedStatement stmt = conn.prepareStatement(query);
                                 ResultSet rs = stmt.executeQuery()) {
                                while (rs.next()) {
                                    int disciplinaId = rs.getInt("disciplina_id");
                                    String nomeDisciplina = rs.getString("nome");
                    %>
                                    <option value="<%= disciplinaId %>" onmousedown="toggleOption(event)"><%= nomeDisciplina %></option>
                    <%  
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>

            <!-- Botão de envio -->
            <div class="text-center">
                <button type="submit" class="btn btn-danger">Cadastrar Curso</button>
            </div>
        </form>
    </div>
</div>

<!-- Script para filtrar disciplinas -->
<script>
    function filterDisciplinas() {
        const searchBar = document.getElementById("searchBar").value.toLowerCase();
        const select = document.getElementById("disciplinas");
        const options = select.getElementsByTagName("option");

        for (let i = 0; i < options.length; i++) {
            const disciplina = options[i].text.toLowerCase();
            if (disciplina.includes(searchBar)) {
                options[i].style.display = "";
            } else {
                options[i].style.display = "none";
            }
        }
    }

    function toggleOption(event) {
        event.preventDefault(); // Impede o comportamento padrão de seleção
        const option = event.target;
        option.selected = !option.selected; // Alterna a seleção manualmente
    }
</script>

</body>
</html>