import type { EmprestimoDTO } from "../interface/EmprestimoDTO.js";
import { DatabaseModel } from "./DatabaseModel.js";

const database = new DatabaseModel().pool;

class Emprestimo {
  private id_emprestimo?: number;
  private id_aluno: number;
  private id_livro: number;
  private data_emprestimo: Date;
  private data_evolucao: Date;
  private status_emprestimo: string;

  constructor(
    _id_aluno: number,
    _id_livro: number,
    _data_emprestimo: Date,
    _data_evolucao: Date,
    _status_emprestimo: string
  ) {
    this.id_aluno = _id_aluno;
    this.id_livro = _id_livro;
    this.data_emprestimo = _data_emprestimo;
    this.data_evolucao = _data_evolucao;
    this.status_emprestimo = _status_emprestimo;
  }

  public getIdAluno(): number {
    return this.id_aluno;
  }

  public setIdAluno(id_aluno: number): void {
    this.id_aluno = id_aluno;
  }

  public getIdLivro(): number {
    return this.id_livro;
  }

  public setIdLivro(id_livro: number): void {
    this.id_livro = id_livro;
  }

  public getDataEmprestimo(): Date {
    return this.data_emprestimo;
  }

  public setDataEmprestimo(data_emprestimo: Date): void {
    this.data_emprestimo = data_emprestimo;
  }

  public getDataEvolucao(): Date {
    return this.data_evolucao;
  }

  public setDataEvolucao(data_evolucao: Date): void {
    this.data_evolucao = data_evolucao;
  }

  public getStatusEmprestimo(): string {
    return this.status_emprestimo;
  }
  public setStatusEmprestimo(status_emprestimo: string): void {
    this.status_emprestimo = status_emprestimo;
  }

  public getIdEmprestimo(): number | undefined {
    return this.id_emprestimo;
  }

  public setIdEmprestimo(id_emprestimo: number): void {
    this.id_emprestimo = id_emprestimo;
  }

  static async listarEmprestimos(): Promise<Array<Emprestimo> | null> {
    try {
      let listaDeEmprestimos: Array<Emprestimo> = [];

      const querySelectEmprestimo = `SELECT * FROM emprestimo;`;

      const respostaBD = await database.query(querySelectEmprestimo);

      respostaBD.rows.forEach((emprestimoBD) => {
        const novoEmprestimo: Emprestimo = new Emprestimo(
          emprestimoBD.id_aluno,
          emprestimoBD.id_livro,
          new Date(emprestimoBD.data_emprestimo),
          new Date(emprestimoBD.data_evolucao),
          emprestimoBD.status_emprestimo
        );

        novoEmprestimo.setIdEmprestimo(emprestimoBD.id_emprestimo);

        listaDeEmprestimos.push(novoEmprestimo);
      });

      return listaDeEmprestimos;
    } catch (error) {
      console.error(`Erro na consulta ao banco de dados. ${error}`);
      return null;
    }
  }

  /**
   * Cadastra um novo empréstimo no banco de dados.
   * Espera um objeto EmprestimoDTO com os campos:
   *  - id_aluno
   *  - id_livro
   *  - data_emprestimo
   *  - data_evolucao
   *  - status_emprestimo
   */
  static async cadastrarEmprestimo(emprestimo: EmprestimoDTO): Promise<boolean> {
    try {
      const queryInsertEmprestimo = `
        INSERT INTO emprestimo
          (id_aluno, id_livro, data_emprestimo, data_evolucao, status_emprestimo)
        VALUES
          ($1, $2, $3, $4, $5)
        RETURNING id_emprestimo;
      `;

      const respostaBD = await database.query(queryInsertEmprestimo, [
        emprestimo.id_aluno,
        emprestimo.id_livro,
        emprestimo.data_emprestimo,
        emprestimo.data_devolucao,
        emprestimo.status_emprestimo,
      ]);

      if (respostaBD.rows.length > 0) {
        console.info(
          `Empréstimo cadastrado com sucesso. ID: ${respostaBD.rows[0].id_emprestimo}`
        );
        return true;
      }

      return false;
      
    } catch (error) {
      console.error(`Erro ao inserir empréstimo no banco de dados. ${error}`);
      return false;
    }
  }
}

export default Emprestimo;
