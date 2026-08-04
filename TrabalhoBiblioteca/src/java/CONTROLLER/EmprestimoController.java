package CONTROLLER;

import DAO.EmprestimoDAO;
import DAO.LivroDAO;
import DAO.UsuarioDAO;
import MODEL.EmprestimoMODEL;
import MODEL.LivroMODEL;
import MODEL.UsuarioMODEL;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

public class EmprestimoController {

    private final EmprestimoDAO emprestimoDAO   = new EmprestimoDAO();
    private final LivroDAO      livroDAO = new LivroDAO();
    private final UsuarioDAO    usuarioDAO  = new UsuarioDAO();

    public void registrar(int idUsuario, int idLivro,
                          Date dataEmprestimo, Date dataPrevistaDevolucao) throws Exception {

        // Valida disponibilidade do livro
        LivroMODEL livro = livroDAO.buscarPorId(idLivro);
        if (livro == null) {
            throw new Exception("Livro não encontrado.");
        }
        if (livro.getQuantidade() <= 0) {
            throw new Exception("Livro indisponível para empréstimo (estoque zerado).");
        }

        // Valida que o usuário está ativo
        UsuarioMODEL usuario = usuarioDAO.buscarPorId(idUsuario);
        if (usuario == null || !"ativo".equals(usuario.getStatus())) {
            throw new Exception("Usuário inativo ou não encontrado.");
        }

        // Valida faixa etária
        int idadeMinima = extrairIdadeMinima(livro.getFaixa_etaria());
        if (idadeMinima > 0) {
            int idadeUsuario = calcularIdade(usuario.getData_nascimento());
            if (idadeUsuario < idadeMinima) {
                throw new Exception(
                    "Empréstimo negado: o usuário tem " + idadeUsuario + " anos e o livro exige " +
                    livro.getFaixa_etaria() + " (mín. " + idadeMinima + " anos)."
                );
            }
        }

        EmprestimoMODEL emp = new EmprestimoMODEL();
        emp.setId_usuario(idUsuario);
        emp.setId_livro(idLivro);
        emp.setData_emprestimo(dataEmprestimo);
        emp.setData_prevista_devolucao(dataPrevistaDevolucao);

        emprestimoDAO.registrarEmprestimo(emp);
        livroDAO.atualizarQuantidade(idLivro, -1);
    }

    public void devolver(int idEmprestimo, Date dataRealDevolucao) throws Exception {

        EmprestimoMODEL emp = emprestimoDAO.buscarPorId(idEmprestimo);
        if (emp == null) {
            throw new Exception("Empréstimo não encontrado.");
        }
        if ("Devolvido".equals(emp.getStatus())) {
            throw new Exception("Este empréstimo já foi devolvido.");
        }

        emprestimoDAO.registrarDevolucao(idEmprestimo, dataRealDevolucao);
        livroDAO.atualizarQuantidade(emp.getId_livro(), 1);
    }

    public void excluir(int idEmprestimo) throws Exception {
        emprestimoDAO.excluirEmprestimo(idEmprestimo);
    }

    public List<EmprestimoMODEL> listar() throws Exception {
        return emprestimoDAO.listarEmprestimos();
    }

    public EmprestimoMODEL buscarPorId(int id) throws Exception {
        return emprestimoDAO.buscarPorId(id);
    }

    private int extrairIdadeMinima(String faixaEtaria) {
        if (faixaEtaria == null || faixaEtaria.equalsIgnoreCase("Livre")) return 0;
        try {
            return Integer.parseInt(faixaEtaria.replace("+", "").trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private int calcularIdade(Date dataNascimento) {
        if (dataNascimento == null) return 0;
        // Converte via java.sql.Date para evitar UnsupportedOperationException do java.sql.Date.toInstant()
        LocalDate nasc = new java.sql.Date(dataNascimento.getTime()).toLocalDate();
        return Period.between(nasc, LocalDate.now()).getYears();
    }
}
