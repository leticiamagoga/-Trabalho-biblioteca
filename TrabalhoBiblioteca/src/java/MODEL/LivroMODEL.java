package MODEL;

public class LivroMODEL {
    private int id_livro;
    private String nome;
    private String autor;
    private int quantidade;
    private String faixa_etaria;
    private String categoria;
    private int ano_publicacao;

    public LivroMODEL() {
    }

    public LivroMODEL(int id_livro, String nome, String autor, int quantidade, String faixa_etaria, String categoria, int ano_publicacao) {
        this.id_livro = id_livro;
        this.nome = nome;
        this.autor = autor;
        this.quantidade = quantidade;
        this.faixa_etaria = faixa_etaria;
        this.categoria = categoria;
        this.ano_publicacao = ano_publicacao;
    }

    public int getId_livro() {
        return id_livro;
    }

    public void setId_livro(int id_livro) {
        this.id_livro = id_livro;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public String getFaixa_etaria() {
        return faixa_etaria;
    }

    public void setFaixa_etaria(String faixa_etaria) {
        this.faixa_etaria = faixa_etaria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getAno_publicacao() {
        return ano_publicacao;
    }

    public void setAno_publicacao(int ano_publicacao) {
        this.ano_publicacao = ano_publicacao;
    }

    
    

}
