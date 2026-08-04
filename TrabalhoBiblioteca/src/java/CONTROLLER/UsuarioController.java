package CONTROLLER;

import DAO.UsuarioDAO;
import MODEL.UsuarioMODEL;
import java.util.Date;
import java.util.List;

public class UsuarioController {

    private final UsuarioDAO dao = new UsuarioDAO();

    public void cadastrar(String nome, Date dataNascimento,
                          String email, String senha, String status) throws Exception {

        UsuarioMODEL usuario = new UsuarioMODEL();
        usuario.setNome(nome);
        usuario.setData_nascimento(dataNascimento);
        usuario.setEmail(email);
        usuario.setSenha(senha);
        usuario.setStatus(status);

        dao.cadastrarUsuario(usuario);
    }

    public void editar(int id, String nome, Date dataNascimento,
                       String email, String senha, String status) throws Exception {

        UsuarioMODEL usuario = new UsuarioMODEL();
        usuario.setId_usuario(id);
        usuario.setNome(nome);
        usuario.setData_nascimento(dataNascimento);
        usuario.setEmail(email);
        usuario.setSenha(senha);
        usuario.setStatus(status);

        dao.editarUsuario(usuario);
    }

    public void excluir(int id) throws Exception {
        dao.excluirUsuario(id);
    }

    public List<UsuarioMODEL> listar() throws Exception {
        return dao.listarUsuarios();
    }

    public UsuarioMODEL buscarPorId(int id) throws Exception {
        return dao.buscarPorId(id);
    }

    public UsuarioMODEL autenticar(String email, String senha) throws Exception {
        UsuarioMODEL usuario = dao.login(email, senha);
        if (usuario == null) {
            throw new Exception("E-mail ou senha inválidos.");
        }
        return usuario;
    }
}
