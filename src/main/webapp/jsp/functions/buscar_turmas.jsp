<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.trabalhojulio.dbconnect.dbconnect" %>

<%
    // Configurar o tipo de conteúdo para que a resposta seja enviada corretamente
    response.setContentType("text/html;charset=UTF-8");

    // Obter o parâmetro cursoId da URL
    String cursoId = request.getParameter("cursoId");

    // Verificar se o cursoId é válido antes de prosseguir
    if (cursoId == null || cursoId.trim().isEmpty()) {
        out.println("<option value=''>Curso inválido</option>");
        return;
    }

    try {
        int cursoIdInt = Integer.parseInt(cursoId); // Converte para inteiro

        // Conectar ao banco de dados e buscar as turmas correspondentes ao curso
        try (Connection conn = dbconnect.getConnection()) {
            String query = "SELECT t.turma_id, t.nome " +
                           "FROM turmas t " +
                           "JOIN turma_disciplinas td ON t.turma_id = td.turma_id " +
                           "JOIN curso_disciplinas cd ON td.disciplina_id = cd.disciplina_id " +
                           "WHERE cd.curso_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, cursoIdInt);

                ResultSet rs = stmt.executeQuery();

                boolean turmasEncontradas = false;
                while (rs.next()) {
                    turmasEncontradas = true;
                    int turmaId = rs.getInt("turma_id");
                    String nomeTurma = rs.getString("nome");
                    out.println("<option value='" + turmaId + "'>" + nomeTurma + "</option>");
                }

                // Caso não encontre turmas para o curso selecionado
                if (!turmasEncontradas) {
                    out.println("<option value=''>Nenhuma turma encontrada</option>");
                }
            }
        }
    } catch (NumberFormatException e) {
        out.println("<option value=''>ID do curso inválido</option>");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<option value=''>Erro ao buscar turmas</option>");
    }
%>
