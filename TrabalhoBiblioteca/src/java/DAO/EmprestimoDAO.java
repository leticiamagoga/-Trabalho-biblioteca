package DAO;

import MODEL.EmprestimoMODEL;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.Conexao;

public class EmprestimoDAO {

    Conexao con = new Conexao();

    Connection conn;
    PreparedStatement pstm;
    ResultSet rs;

    public void registrarEmprestimo(EmprestimoMODEL emp) throws Exception {

        String sql = "INSERT INTO emprestimos "
                   + "(id_usuario, id_livro, data_emprestimo, data_prevista_devolucao, status) "
                   + "VALUES (?, ?, ?, ?, 'Emprestado')";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, emp.getId_usuario());
        pstm.setInt(2, emp.getId_livro());
        pstm.setDate(3, new java.sql.Date(emp.getData_emprestimo().getTime()));
        pstm.setDate(4, new java.sql.Date(emp.getData_prevista_devolucao().getTime()));

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public void registrarDevolucao(int idEmprestimo, java.util.Date dataReal) throws Exception {

        // Busca data prevista para calcular multa (R$ 1,00 por dia de atraso)
        EmprestimoMODEL emp = buscarPorId(idEmprestimo);
        BigDecimal multa = BigDecimal.ZERO;

        if (emp != null && dataReal.after(emp.getData_prevista_devolucao())) {
            long diff = dataReal.getTime() - emp.getData_prevista_devolucao().getTime();
            long diasAtraso = diff / (1000 * 60 * 60 * 24);
            multa = new BigDecimal(diasAtraso);
        }

        String sql = "UPDATE emprestimos SET "
                   + "data_real_devolucao = ?, "
                   + "multa = ?, "
                   + "status = 'Devolvido' "
                   + "WHERE id_emprestimo = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setDate(1, new java.sql.Date(dataReal.getTime()));
        pstm.setBigDecimal(2, multa);
        pstm.setInt(3, idEmprestimo);

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public void excluirEmprestimo(int idEmprestimo) throws Exception {

        String sql = "DELETE FROM emprestimos WHERE id_emprestimo = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, idEmprestimo);

        pstm.executeUpdate();

        pstm.close();
        conn.close();
    }

    public List<EmprestimoMODEL> listarEmprestimos() throws Exception {

        List<EmprestimoMODEL> lista = new ArrayList<>();

        String sql = "SELECT e.*, u.nome AS nome_usuario, l.nome AS nome_livro "
                   + "FROM emprestimos e "
                   + "JOIN usuarios u ON e.id_usuario = u.id_usuario "
                   + "JOIN livros l ON e.id_livro = l.id_livro "
                   + "ORDER BY e.id_emprestimo DESC";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);
        rs = pstm.executeQuery();

        while (rs.next()) {
            EmprestimoMODEL emp = new EmprestimoMODEL();

            emp.setId_emprestimo(rs.getInt("id_emprestimo"));
            emp.setId_usuario(rs.getInt("id_usuario"));
            emp.setId_livro(rs.getInt("id_livro"));
            emp.setData_emprestimo(rs.getDate("data_emprestimo"));
            emp.setData_prevista_devolucao(rs.getDate("data_prevista_devolucao"));
            emp.setData_real_devolucao(rs.getDate("data_real_devolucao"));
            emp.setMulta(rs.getBigDecimal("multa"));
            emp.setStatus(rs.getString("status"));
            emp.setNome_usuario(rs.getString("nome_usuario"));
            emp.setNome_livro(rs.getString("nome_livro"));

            lista.add(emp);
        }

        rs.close();
        pstm.close();
        conn.close();

        return lista;
    }

    public EmprestimoMODEL buscarPorId(int idEmprestimo) throws Exception {

        EmprestimoMODEL emp = null;

        String sql = "SELECT e.*, u.nome AS nome_usuario, l.nome AS nome_livro "
                   + "FROM emprestimos e "
                   + "JOIN usuarios u ON e.id_usuario = u.id_usuario "
                   + "JOIN livros l ON e.id_livro = l.id_livro "
                   + "WHERE e.id_emprestimo = ?";

        conn = con.conectar();
        pstm = conn.prepareStatement(sql);

        pstm.setInt(1, idEmprestimo);

        rs = pstm.executeQuery();

        if (rs.next()) {
            emp = new EmprestimoMODEL();

            emp.setId_emprestimo(rs.getInt("id_emprestimo"));
            emp.setId_usuario(rs.getInt("id_usuario"));
            emp.setId_livro(rs.getInt("id_livro"));
            emp.setData_emprestimo(rs.getDate("data_emprestimo"));
            emp.setData_prevista_devolucao(rs.getDate("data_prevista_devolucao"));
            emp.setData_real_devolucao(rs.getDate("data_real_devolucao"));
            emp.setMulta(rs.getBigDecimal("multa"));
            emp.setStatus(rs.getString("status"));
            emp.setNome_usuario(rs.getString("nome_usuario"));
            emp.setNome_livro(rs.getString("nome_livro"));
        }

        rs.close();
        pstm.close();
        conn.close();

        return emp;
    }
}
