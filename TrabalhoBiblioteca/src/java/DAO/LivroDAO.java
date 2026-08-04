package DAO;

import MODEL.LivroMODEL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.Conexao;

public class LivroDAO {

    Conexao con = new Conexao();

    Connection conn;
    PreparedStatement pstm;
    ResultSet rs;

    public void cadastrarLivro(LivroMODEL livro) throws Exception {

        String sql = "INSERT INTO livros "
                   + "(nome, autor, quantidade, faixa_etaria, categoria, ano_publicacao) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setString(1, livro.getNome());
        pstm.setString(2, livro.getAutor());
        pstm.setInt(3, livro.getQuantidade());
        pstm.setString(4, livro.getFaixa_etaria());
        pstm.setString(5, livro.getCategoria());
        pstm.setInt(6, livro.getAno_publicacao());

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public void editarLivro(LivroMODEL livro) throws Exception {

        String sql = "UPDATE livros SET "
                   + "nome = ?, "
                   + "autor = ?, "
                   + "quantidade = ?, "
                   + "faixa_etaria = ?, "
                   + "categoria = ?, "
                   + "ano_publicacao = ? "
                   + "WHERE id_livro = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setString(1, livro.getNome());
        pstm.setString(2, livro.getAutor());
        pstm.setInt(3, livro.getQuantidade());
        pstm.setString(4, livro.getFaixa_etaria());
        pstm.setString(5, livro.getCategoria());
        pstm.setInt(6, livro.getAno_publicacao());
        pstm.setInt(7, livro.getId_livro());

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public void excluirLivro(int idLivro) throws Exception {

        String sql = "DELETE FROM livros WHERE id_livro = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, idLivro);

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public List<LivroMODEL> listarLivros() throws Exception {

        List<LivroMODEL> lista = new ArrayList<>();

        String sql = "SELECT * FROM livros ORDER BY nome";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();

        while (rs.next()) {
            LivroMODEL livro = new LivroMODEL();

            livro.setId_livro(rs.getInt("id_livro"));
            livro.setNome(rs.getString("nome"));
            livro.setAutor(rs.getString("autor"));
            livro.setQuantidade(rs.getInt("quantidade"));
            livro.setFaixa_etaria(rs.getString("faixa_etaria"));
            livro.setCategoria(rs.getString("categoria"));
            livro.setAno_publicacao(rs.getInt("ano_publicacao"));

            lista.add(livro);
        }

        rs.close();
        pstm.close();
        conn.close();

        return lista;
    }

    public LivroMODEL buscarPorId(int idLivro) throws Exception {

        LivroMODEL livro = null;

        String sql = "SELECT * FROM livros WHERE id_livro = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, idLivro);

        rs = pstm.executeQuery();

        if (rs.next()) {
            livro = new LivroMODEL();

            livro.setId_livro(rs.getInt("id_livro"));
            livro.setNome(rs.getString("nome"));
            livro.setAutor(rs.getString("autor"));
            livro.setQuantidade(rs.getInt("quantidade"));
            livro.setFaixa_etaria(rs.getString("faixa_etaria"));
            livro.setCategoria(rs.getString("categoria"));
            livro.setAno_publicacao(rs.getInt("ano_publicacao"));
        }

        rs.close();
        pstm.close();
        conn.close();

        return livro;
    }

    public void atualizarQuantidade(int idLivro, int delta) throws Exception {

        String sql = "UPDATE livros SET quantidade = quantidade + ? WHERE id_livro = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, delta);
        pstm.setInt(2, idLivro);

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }
}
