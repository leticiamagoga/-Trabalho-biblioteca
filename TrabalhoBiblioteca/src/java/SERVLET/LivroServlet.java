package SERVLET;

import CONTROLLER.LivroController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/livros")
public class LivroServlet extends HttpServlet {

    private final LivroController ctr = new LivroController();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        if (acao == null) acao = "listar";

        try {
            switch (acao) {
                case "listar" -> {
                    req.setAttribute("livros", ctr.listar());
                    req.getRequestDispatcher("/livros/lista.jsp").forward(req, resp);
                }
                case "novo" -> {
                    req.getRequestDispatcher("/livros/form.jsp").forward(req, resp);
                }
                case "editar" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("livro", ctr.buscarPorId(id));
                    req.getRequestDispatcher("/livros/form.jsp").forward(req, resp);
                }
                case "excluir" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    ctr.excluir(id);
                    resp.sendRedirect(req.getContextPath() + "/livros?acao=listar&msg=excluido");
                }
                default -> resp.sendRedirect(req.getContextPath() + "/livros?acao=listar");
            }
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/livros/lista.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");

        String nome      = req.getParameter("nome");
        String autor     = req.getParameter("autor");
        int quantidade   = Integer.parseInt(req.getParameter("quantidade"));
        String faixa     = req.getParameter("faixaEtaria");
        String categoria = req.getParameter("categoria");
        String anoStr    = req.getParameter("anoPublicacao");
        int ano          = (anoStr != null && !anoStr.isEmpty()) ? Integer.parseInt(anoStr) : 0;

        try {
            if ("salvar".equals(acao)) {
                ctr.cadastrar(nome, autor, quantidade, faixa, categoria, ano);
                resp.sendRedirect(req.getContextPath() + "/livros?acao=listar&msg=cadastrado");

            } else if ("atualizar".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("idLivro"));
                ctr.editar(id, nome, autor, quantidade, faixa, categoria, ano);
                resp.sendRedirect(req.getContextPath() + "/livros?acao=listar&msg=atualizado");
            }
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/livros/form.jsp").forward(req, resp);
        }
    }
}
