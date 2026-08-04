package SERVLET;

import CONTROLLER.UsuarioController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {

    private final UsuarioController ctr = new UsuarioController();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        if (acao == null) acao = "listar";

        try {
            switch (acao) {
                case "listar" -> {
                    req.setAttribute("usuarios", ctr.listar());
                    req.getRequestDispatcher("/usuarios/lista.jsp").forward(req, resp);
                }
                case "novo" -> {
                    req.getRequestDispatcher("/usuarios/form.jsp").forward(req, resp);
                }
                case "editar" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("usuario", ctr.buscarPorId(id));
                    req.getRequestDispatcher("/usuarios/form.jsp").forward(req, resp);
                }
                case "excluir" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    ctr.excluir(id);
                    resp.sendRedirect(req.getContextPath() + "/usuarios?acao=listar&msg=excluido");
                }
                default -> resp.sendRedirect(req.getContextPath() + "/usuarios?acao=listar");
            }
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/usuarios/lista.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            String nome   = req.getParameter("nome");
            String email  = req.getParameter("email");
            String senha  = req.getParameter("senha");
            String status = req.getParameter("status");
            java.util.Date dataNasc = sdf.parse(req.getParameter("dataNascimento"));

            if ("salvar".equals(acao)) {
                ctr.cadastrar(nome, dataNasc, email, senha, status);
                resp.sendRedirect(req.getContextPath() + "/usuarios?acao=listar&msg=cadastrado");

            } else if ("atualizar".equals(acao)) {
                int id = Integer.parseInt(req.getParameter("idUsuario"));
                ctr.editar(id, nome, dataNasc, email, senha, status);
                resp.sendRedirect(req.getContextPath() + "/usuarios?acao=listar&msg=atualizado");
            }
        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/usuarios/form.jsp").forward(req, resp);
        }
    }
}
