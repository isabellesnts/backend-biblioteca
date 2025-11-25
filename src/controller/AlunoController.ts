import Aluno from "../model/Aluno.js";
import type { Request, Response } from "express";

class AlunoController extends Aluno {
  /**
   * Lista todos os alunos
   */
  static async todos(req: Request, res: Response): Promise<Response> {
    try {

      const listarAluno: Array<Aluno> | null = await this.listarAlunos();
      return res.status(200).json(listarAluno);
      } catch (error) {


        console.error(`Erro ao consultar modelo. ${error}`);

        return res.status(500).json({ mensagem: "Não foi possivel acessar a lista de Alunos." });
    }
  }

  /**
   * Busca aluno por ID
   */
  static async buscarAluno(req: Request, res: Response): Promise<Response> {
    try {

      const idAluno: number = parseInt(req.params.idAluno as string);

      if (isNaN(idAluno) || idAluno <= 0) {
        return res.status(400).json({ mensagem: "ID do Aluno inválido." });
      }

    const respostaModelo: Aluno | null = await Aluno.listarAluno(idAluno);

    return res.status(200).json(respostaModelo);

    } catch (error) {

      console.error(`Erro ao acessar o modelo. ${error}`);

      return res.status(500).json({ mensagem: "Não foi possivel recuperar o Aluno." });
    }
  }

  /**
   * Cadastra um novo aluno
   */
  static async novo(req: Request, res: Response): Promise<Response> {
    try {

      const dadosRecebidosAluno = req.body;

      const respostaModelo = await Aluno.cadastrarAluno(dadosRecebidosAluno);

      if (respostaModelo) {

        return res.status(201).json({ mensagem: "Aluno cadastrado com sucesso." });
      } else {

        return res.status(400).json({ mensagem: "Erro ao cadastrar Aluno." });
      }
    } catch (error) {

      console.error(`Erro no modelo. ${error}`);
      return res.status(500).json({ mensagem: "Não foi possivel inserir o Aluno." });
    }
  }
}

export default AlunoController;
