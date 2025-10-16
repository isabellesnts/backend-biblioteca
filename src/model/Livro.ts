class Livro {
    private titulo: string;
    private autor: string;
    private editora: string;
    private ano_publicacao: string;
    private isbn: string;   
    private quant_total: number;
    private quant_disponivel: number;
    private valor_aquisicao: number;
    private status_livro_emprestimo: string;

    constructor(
        titulo: string,
        autor: string,
        editora: string,
        ano_publicacao: string,
        isbn: string,
        quant_total: number,
        quant_disponivel: number,
        valor_aquisicao: number,
        status_livro_emprestimo: string
    ) {
        this.titulo = titulo;
        this.autor = autor;
        this.editora = editora;
        this.ano_publicacao = ano_publicacao;
        this.isbn = isbn;
        this.quant_total = quant_total;
        this.quant_disponivel = quant_disponivel;
        this.valor_aquisicao = valor_aquisicao;
        this.status_livro_emprestimo = status_livro_emprestimo;
    }
    public 