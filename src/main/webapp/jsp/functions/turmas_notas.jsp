<%@page import="java.sql.*" %>
<%@page contentType="application/json" %>
<%@page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>
<%
    // Captura o par�metro 'curso_id' da requisi��o
    String cursoId = request.getParameter("curso_id");

    // Adicionando log para depura��o
    System.out.println("Par�metro recebido no JSP: curso_id = " + cursoId);

    // Verifica��o se o 'curso_id' foi realmente fornecido
    if (cursoId == null || cursoId.trim().isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        out.print("{\"error\": \"ID do curso n�o fornecido\"}");
        return;
    }

    try {
        // Tenta converter 'curso_id' para um n�mero
        int cursoIdInt = Integer.parseInt(cursoId);
        response.setContentType("application/json");

        try (Connection conn = dbconnect.getConnection()) {
            // Adicionando log para confirmar conex�o
            System.out.println("Conex�o estabelecida com sucesso!");

            String query = "SELECT t.turma_id, t.nome FROM turmas t " +
                           "JOIN curso_turmas ct ON ct.turma_id = t.turma_id WHERE ct.curso_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, cursoIdInt);
                ResultSet rs = stmt.executeQuery();

                StringBuilder jsonResponse = new StringBuilder("[");
                while (rs.next()) {
                    jsonResponse.append("{");
                    jsonResponse.append("\"turma_id\": ").append(rs.getInt("turma_id")).append(",");
                    jsonResponse.append("\"nome\": \"").append(rs.getString("nome")).append("\"");
                    jsonResponse.append("},");
                }

                // Verifica��o se houve resultados
                if (jsonResponse.length() > 1) {
                    jsonResponse.deleteCharAt(jsonResponse.length() - 1); // Remove a �ltima v�rgula
                } else {
                    System.out.println("Nenhuma turma encontrada para o curso_id: " + cursoId);
                }
                
                jsonResponse.append("]");
                out.print(jsonResponse.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Erro ao consultar o banco de dados\"}");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        out.print("{\"error\": \"ID do curso inv�lido\"}");
    }
%>
