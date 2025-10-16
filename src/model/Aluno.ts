class Aluno {
    private ra: string;
    private nome: string;
    private sobrenome: string;
    private data_nascimento: Date;
    private endereco: string;
    private email: string;
    private celular: string;


    constructor(
        ra: string,
        nome: string,
        sobrenome: string,
        data_nascimento: Date,
        endereco: string,
        email: string,
        celular: string
){

        this.ra = ra;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.data_nascimento = data_nascimento;
        this.endereco = endereco;
        this.email = email;
        this.celular = celular;
}
    public getRa(): string {
        return this.ra;
    }
    public setRa(ra: string): void {
        this.ra = ra;
    }
    public getNome(): string {
        return this.nome;
    }
    public setNome(nome: string): void {
        this.nome = nome;
    }
    public getSobrenome(): string {
        return this.sobrenome;
    }
    public setSobrenome(sobrenome: string): void {
        this.sobrenome = sobrenome;
    }
    public getDataNascimento(): Date {
        return this.data_nascimento;
    }
    public setDataNascimento(data_nascimento: Date): void {
        this.data_nascimento = data_nascimento;
    }
    public getEndereco(): string {
        return this.endereco;
    }
    public setEndereco(endereco: string): void {
        this.endereco = endereco;
    }
    public getEmail(): string {
        return this.email;
    }
    public setEmail(email: string): void {
        this.email = email;
    }
    public getCelular(): string {
        return this.celular;
    }
    public setCelular(celular: string): void {
        this.celular = celular;
}
}
export default Aluno; 
