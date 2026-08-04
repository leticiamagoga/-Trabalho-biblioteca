package DAO;

import MODEL.UsuarioMODEL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.Conexao;

public class UsuarioDAO {

    Conexao con = new Conexao();

    Connection conn;
    PreparedStatement pstm;
    ResultSet rs;

    public void cadastrarUsuario(UsuarioMODEL usuario) throws Exception {

        String sql = "INSERT INTO usuarios "
                   + "(nome, data_nascimento, email, senha, status) "
                   + "VALUES (?, ?, ?, ?, ?)";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setString(1, usuario.getNome());
        pstm.setDate(2, new java.sql.Date(usuario.getData_nascimento().getTime()));
        pstm.setString(3, usuario.getEmail());
        pstm.setString(4, usuario.getSenha());
        pstm.setString(5, usuario.getStatus());

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public void editarUsuario(UsuarioMODEL usuario) throws Exception {

        String sql = "UPDATE usuarios SET "
                   + "nome = ?, "
                   + "data_nascimento = ?, "
                   + "email = ?, "
                   + "senha = ?, "
                   + "status = ? "
                   + "WHERE id_usuario = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setString(1, usuario.getNome());
        pstm.setDate(2, new java.sql.Date(usuario.getData_nascimento().getTime()));
        pstm.setString(3, usuario.getEmail());
        pstm.setString(4, usuario.getSenha());
        pstm.setString(5, usuario.getStatus());
        pstm.setInt(6, usuario.getId_usuario());

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public void excluirUsuario(int idUsuario) throws Exception {

        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, idUsuario);

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public List<UsuarioMODEL> listarUsuarios() throws Exception {

        List<UsuarioMODEL> lista = new ArrayList<>();

        String sql = "SELECT * FROM usuarios ORDER BY id_usuario";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();

        while (rs.next()) {
            UsuarioMODEL usuario = new UsuarioMODEL();

            usuario.setId_usuario(rs.getInt("id_usuario"));
            usuario.setNome(rs.getString("nome"));
            usuario.setData_nascimento(rs.getDate("data_nascimento"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setStatus(rs.getString("status"));

            lista.add(usuario);
        }

        rs.close();
        pstm.close();
        conn.close();

        return lista;
    }

    public UsuarioMODEL buscarPorId(int idUsuario) throws Exception {

        UsuarioMODEL usuario = null;

        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, idUsuario);

        rs = pstm.executeQuery();

        if (rs.next()) {
            usuario = new UsuarioMODEL();

            usuario.setId_usuario(rs.getInt("id_usuario"));
            usuario.setNome(rs.getString("nome"));
            usuario.setData_nascimento(rs.getDate("data_nascimento"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setStatus(rs.getString("status"));
        }

        rs.close();
        pstm.close();
        conn.close();

        return usuario;
    }

    public UsuarioMODEL login(String email, String senha) throws Exception {

        UsuarioMODEL usuario = null;

        String sql = "SELECT * FROM usuarios "
                   + "WHERE email = ? AND senha = ? AND status = 'ativo'";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setString(1, email);
        pstm.setString(2, senha);

        rs = pstm.executeQuery();

        if (rs.next()) {
            usuario = new UsuarioMODEL();

            usuario.setId_usuario(rs.getInt("id_usuario"));
            usuario.setNome(rs.getString("nome"));
            usuario.setData_nascimento(rs.getDate("data_nascimento"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setStatus(rs.getString("status"));
        }

        rs.close();
        pstm.close();
        conn.close();

        return usuario;
    }
}