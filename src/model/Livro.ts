import type { LivroDTO } from "../interface/LivroDTO.js";
import { DatabaseModel } from "./DatabaseModel.js";


const database = new DatabaseModel().pool;

class Livro {

    private idLivro: number = 0;
    private editora: string;
    private anoPublicacao: string;
    private isbn: string;
    private quantidadeTotal: number
    /**
     * Construtor da classe Livro
     * @param _editora Editora do livro
     * @param _anoPublicacao Ano de publicação
     * @param _isbn Código ISBN
     * @param _quantidadeTotal Quantidade total de exemplares
     */
    constructor(
        _editora: string,
        _anoPublicacao: string,
        _isbn: string,
        _quantidadeTotal: number
    ) {
        this.editora = _editora;
        this.anoPublicacao = _anoPublicacao;
        this.isbn = _isbn;
        this.quantidadeTotal = _quantidadeTotal
    }

    public getIdLivro(): number {
        return this.idLivro;
    }

    public setIdLivro(idLivro: number): void {
        this.idLivro = idLivro;
    }

    public getEditora(): string {
        return this.editora;
    }

    public setEditora(editora: string): void {
        this.editora = editora;
    }

    public getAnoPublicacao(): string {
        return this.anoPublicacao;
    }

    public setAnoPublicacao(anoPublicacao: string): void {
        this.anoPublicacao = anoPublicacao;
    
    }

    public getIsbn(): string {
        return this.isbn;
    }

    public setIsbn(isbn: string): void {
        this.isbn = isbn;
    }

    public getQuantidadeTotal(): number {
        return this.quantidadeTotal;
    }

    public setQuantidadeTotal(quantidadeTotal: number): void {
        this.quantidadeTotal = quantidadeTotal;
    }

    static async listarLivros(): Promise<Array<Livro> | null> {
        try {
            const listaDeLivros: Array<Livro> = [];
            const querySelectLivros = `SELECT * FROM Livros;`;
            const respostaBD = await database.query(querySelectLivros);

            respostaBD.rows.forEach((respostaBD : any) => {
                const novoLivro: Livro = new Livro(
                    respostaBD.editora,
                    respostaBD.ano_publicacao,
                    respostaBD.isbn,
                    respostaBD.quantidade_total
                );

                novoLivro.setIdLivro(respostaBD.id_livro);
                listaDeLivros.push(novoLivro);
            });

            return listaDeLivros;
        } catch (error) {
            console.error(`Erro na consulta ao banco de dados. ${error}`);
            return null;
        }
    }

    static async cadastrarLivro(livro: LivroDTO): Promise<boolean> {
        try {
            const queryInsertLivro = `
                INSERT INTO Livros (editora, ano_publicacao, isbn, quant_total,)
                VALUES ($1, $2, $3, $4, $5)
                RETURNING id_livro;
            `;

            const respostaBD = await database.query(queryInsertLivro, [
                livro.editora,
                livro.ano_publicacao,
                livro.isbn,
                livro.quant_total,
                
            ]);

            if (respostaBD.rows.length > 0) {
                console.info(`Livro cadastrado com sucesso. ID: ${respostaBD.rows[0].id_livro}`);
                return true;
            }

            return false;
        } catch (error) {
            console.error(`Erro ao cadastrar Livro no banco de dados. ${error}`);
            return false;
        }
    }

    static async listarLivro(idLivro: number): Promise<Livro | null> {
        try {
            const querySelectLivro = `SELECT * FROM Livros WHERE id_livro = $1;`;
            const respostaBD = await database.query(querySelectLivro, [idLivro]);

            if (respostaBD.rowCount !== 0) {
                const livroBD = respostaBD.rows[0];
                const livro: Livro = new Livro(
                    livroBD.editora,
                    livroBD.ano_publicacao,
                    livroBD.isbn,
                    livroBD.quant_total
                );
                livro.setIdLivro(livroBD.id_livro);

                return livro;
            }

            return null;
        } catch (error) {
            console.error(`Erro ao buscar Livro no banco de dados. ${error}`);
            return null;
        }
    }
}

export default Livro;