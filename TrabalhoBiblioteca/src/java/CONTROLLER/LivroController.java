package CONTROLLER;

import DAO.LivroDAO;
import MODEL.LivroMODEL;
import java.util.List;

public class LivroController {

    private final LivroDAO dao = new LivroDAO();

    public void cadastrar(String nome, String autor, int quantidade,
                          String faixaEtaria, String categoria, int anoPublicacao) throws Exception {

        LivroMODEL livro = new LivroMODEL();
        livro.setNome(nome);
        livro.setAutor(autor);
        livro.setQuantidade(quantidade);
        livro.setFaixa_etaria(faixaEtaria);
        livro.setCategoria(categoria);
        livro.setAno_publicacao(anoPublicacao);

        dao.cadastrarLivro(livro);
    }

    public void editar(int id, String nome, String autor, int quantidade,
                       String faixaEtaria, String categoria, int anoPublicacao) throws Exception {

        LivroMODEL livro = new LivroMODEL();
        livro.setId_livro(id);
        livro.setNome(nome);
        livro.setAutor(autor);
        livro.setQuantidade(quantidade);
        livro.setFaixa_etaria(faixaEtaria);
        livro.setCategoria(categoria);
        livro.setAno_publicacao(anoPublicacao);

        dao.editarLivro(livro);
    }

    public void excluir(int id) throws Exception {
        dao.excluirLivro(id);
    }

    public List<LivroMODEL> listar() throws Exception {
        return dao.listarLivros();
    }

    public LivroMODEL buscarPorId(int id) throws Exception {
        return dao.buscarPorId(id);
    }
}
