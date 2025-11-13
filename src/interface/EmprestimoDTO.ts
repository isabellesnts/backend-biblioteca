export interface EmprestimoDTO {
    id_emprestimo?: number; // opcional (gerado automaticamente)
    ra_aluno: string; // RA do aluno que pegou o livro
    isbn_livro: string; // ISBN do livro emprestado
    data_emprestimo: Date;
    data_devolucao: Date;
    status_emprestimo: string; // Ex: "Em andamento", "Devolvido", "Atrasado"
}
