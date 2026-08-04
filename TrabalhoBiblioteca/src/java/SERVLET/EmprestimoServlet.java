package SERVLET;

import CONTROLLER.EmprestimoController;
import CONTROLLER.LivroController;
import CONTROLLER.UsuarioController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/emprestimos")
public class EmprestimoServlet extends HttpServlet {

    private final EmprestimoController ctr      = new EmprestimoController();
    private final UsuarioController    userCTR  = new UsuarioController();
    private final LivroController      livroCTR = new LivroController();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        if (acao == null) acao = "listar";

        try {
            switch (acao) {
                case "listar" -> {
                    req.setAttribute("emprestimos", ctr.listar());
                    req.getRequestDispatcher("/emprestimos/lista.jsp").forward(req, resp);
                }
                case "novo" -> {
                    req.setAttribute("usuarios", userCTR.listar());
                    req.setAttribute("livros", livroCTR.listar());
                    req.getRequestDispatcher("/emprestimos/form.jsp").forward(req, resp);
                }
                case "devolver" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("emprestimo", ctr.buscarPorId(id));
                    req.getRequestDispatcher("/emprestimos/formDevolucao.jsp").forward(req, resp);
                }
                case "excluir" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    ctr.excluir(id);
                    resp.sendRedirect(req.getContextPath() + "/emprestimos?acao=listar&msg=excluido");
                }
                default -> resp.sendRedirect(req.getContextPath() + "/emprestimos?acao=listar");
            }
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/emprestimos/lista.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if ("salvar".equals(acao)) {
            try {
                int idUsuario = Integer.parseInt(req.getParameter("idUsuario"));
                int idLivro   = Integer.parseInt(req.getParameter("idLivro"));
                java.util.Date dataEmp  = sdf.parse(req.getParameter("dataEmprestimo"));
                java.util.Date dataPrev = sdf.parse(req.getParameter("dataPrevistaDevolucao"));

                ctr.registrar(idUsuario, idLivro, dataEmp, dataPrev);
                resp.sendRedirect(req.getContextPath() + "/emprestimos?acao=listar&msg=cadastrado");

            } catch (Exception e) {
                req.setAttribute("erro", e.getMessage());
                try {
                    req.setAttribute("usuarios", userCTR.listar());
                    req.setAttribute("livros", livroCTR.listar());
                } catch (Exception ignored) {}
                req.getRequestDispatcher("/emprestimos/form.jsp").forward(req, resp);
            }

        } else if ("confirmarDevolucao".equals(acao)) {
            try {
                int id = Integer.parseInt(req.getParameter("idEmprestimo"));
                java.util.Date dataReal = sdf.parse(req.getParameter("dataRealDevolucao"));

                ctr.devolver(id, dataReal);
                resp.sendRedirect(req.getContextPath() + "/emprestimos?acao=listar&msg=devolvido");

            } catch (Exception e) {
                req.setAttribute("erro", e.getMessage());
                try {
                    int id = Integer.parseInt(req.getParameter("idEmprestimo"));
                    req.setAttribute("emprestimo", ctr.buscarPorId(id));
                } catch (Exception ignored) {}
                req.getRequestDispatcher("/emprestimos/formDevolucao.jsp").forward(req, resp);
            }
        }
    }
}
