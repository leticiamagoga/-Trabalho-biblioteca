package MODEL;

import java.math.BigDecimal;
import java.util.Date;

public class EmprestimoMODEL {

    private int id_emprestimo;
    private int id_usuario;
    private int id_livro;
    private Date data_emprestimo;
    private Date data_prevista_devolucao;
    private Date data_real_devolucao;
    private BigDecimal multa;
    private String status;
    private String nome_usuario;
    private String nome_livro;

    public EmprestimoMODEL() {
    }

    public EmprestimoMODEL(int id_emprestimo, int id_usuario, int id_livro,
            Date data_emprestimo, Date data_prevista_devolucao,
            Date data_real_devolucao, BigDecimal multa,
            String status, String nome_usuario, String nome_livro) {

        this.id_emprestimo = id_emprestimo;
        this.id_usuario = id_usuario;
        this.id_livro = id_livro;
        this.data_emprestimo = data_emprestimo;
        this.data_prevista_devolucao = data_prevista_devolucao;
        this.data_real_devolucao = data_real_devolucao;
        this.multa = multa;
        this.status = status;
        this.nome_usuario = nome_usuario;
        this.nome_livro = nome_livro;
    }

    public int getId_emprestimo() {
        return id_emprestimo;
    }

    public void setId_emprestimo(int id_emprestimo) {
        this.id_emprestimo = id_emprestimo;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_livro() {
        return id_livro;
    }

    public void setId_livro(int id_livro) {
        this.id_livro = id_livro;
    }

    public Date getData_emprestimo() {
        return data_emprestimo;
    }

    public void setData_emprestimo(Date data_emprestimo) {
        this.data_emprestimo = data_emprestimo;
    }

    public Date getData_prevista_devolucao() {
        return data_prevista_devolucao;
    }

    public void setData_prevista_devolucao(Date data_prevista_devolucao) {
        this.data_prevista_devolucao = data_prevista_devolucao;
    }

    public Date getData_real_devolucao() {
        return data_real_devolucao;
    }

    public void setData_real_devolucao(Date data_real_devolucao) {
        this.data_real_devolucao = data_real_devolucao;
    }

    public BigDecimal getMulta() {
        return multa;
    }

    public void setMulta(BigDecimal multa) {
        this.multa = multa;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNome_usuario() {
        return nome_usuario;
    }

    public void setNome_usuario(String nome_usuario) {
        this.nome_usuario = nome_usuario;
    }

    public String getNome_livro() {
        return nome_livro;
    }

    public void setNome_livro(String nome_livro) {
        this.nome_livro = nome_livro;
    }
}