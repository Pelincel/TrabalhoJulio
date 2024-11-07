package com.mycompany.trabalhojulio;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/jsp/*") // Aplica o filtro para todas as p�ginas JSP na pasta /jsp
public class LoginFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicializa��o do filtro (caso seja necess�rio)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Verifica se o usu�rio est� logado
        if (session == null || session.getAttribute("usuarioId") == null) {
            res.sendRedirect(req.getContextPath() + "/index.jsp"); // Redireciona para login se n�o estiver logado
        } else {
            chain.doFilter(request, response); // Usu�rio logado, continua com a requisi��o
        }
    }

    @Override
    public void destroy() {
        // Limpeza de recursos, se necess�rio
    }
}
