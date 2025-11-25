export interface EmprestimoDTO {
    id_emprestimo?: number; // opcional (gerado automaticamente)
    ra_aluno: string; // RA do aluno que pegou o livro
    isbn_livro: string; // ISBN do livro emprestado
    data_emprestimo: Date;
    data_devolucao: Date;
    id_aluno: number;
    id_livro: number;
    status_emprestimo: string; // Ex: "Em andamento", "Devolvido", "Atrasado"
}
