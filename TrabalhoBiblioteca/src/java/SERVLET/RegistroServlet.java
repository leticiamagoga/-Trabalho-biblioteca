package SERVLET;

import CONTROLLER.UsuarioController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private final UsuarioController ctr = new UsuarioController();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/registro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nome     = req.getParameter("nome");
        String email    = req.getParameter("email");
        String senha    = req.getParameter("senha");
        String confirma = req.getParameter("confirmarSenha");

        if (!senha.equals(confirma)) {
            req.setAttribute("erro", "As senhas não coincidem.");
            req.setAttribute("nome", nome);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dataNasc = sdf.parse(req.getParameter("dataNascimento"));

            ctr.cadastrar(nome, dataNasc, email, senha, "ativo");

            resp.sendRedirect(req.getContextPath() + "/login?msg=registrado");

        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("nome", nome);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
        }
    }
}
