-- CREATE ALUNO - TRIGGER - FUNCTION

CREATE SEQUENCE seq_ra START 1;

CREATE TABLE Aluno (
    id_aluno INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ra VARCHAR (7) UNIQUE NOT NULL,
    nome VARCHAR (80) NOT NULL,
    sobrenome VARCHAR (80) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR (200),
    email VARCHAR (80),
    celular VARCHAR (20) NOT NULL
);

-- cria o RA
CREATE OR REPLACE FUNCTION gerar_ra() RETURNS TRIGGER AS $$
BEGIN
    NEW.ra := 'AAA' || TO_CHAR(nextval('seq_ra'), 'FM0000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_gerar_ra
BEFORE INSERT ON Aluno
FOR EACH ROW EXECUTE FUNCTION gerar_ra();

-- CREATE LIVRO
CREATE TABLE Livro (
    id_livro INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR (200) NOT NULL,
    autor VARCHAR (150) NOT NULL,
    editora VARCHAR (100) NOT NULL,
    ano_publicacao VARCHAR (5),
    isbn VARCHAR (20),
    quant_total INTEGER NOT NULL,
    quant_disponivel INTEGER NOT NULL,
    valor_aquisicao DECIMAL (10,2),
    status_livro_emprestado VARCHAR (20)
);

-- CREATE EMPRESTIMO
CREATE TABLE Emprestimo (
    id_emprestimo INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    id_livro INT REFERENCES Livro(id_livro),
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR (20)
);

-- ALUNO
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Conor', 'McGregor', '2005-01-15', 'Rua UFC, 123', 'mcgregor@ufc.com', '16998959876'),
('Amanda', 'Nunes', '2004-03-22', 'Rua UFC, 456', 'amanda.nunes@ufc.com', '16995992305'),
('Angelina', 'Jolie', '2003-07-10', 'Rua Hollywood, 789', 'jolie@cinema.com', '16991915502'),
('Natalie', 'Portman', '2002-11-05', 'Rua Hollywood, 101', 'natalie.portman@cinema.com', '16993930703'),
('Shaquille', 'ONeal', '2004-09-18', 'Rua NBA, 202', 'shaquille@gmail.com', '16993937030'),
('Harry', 'Kane', '2000-05-18', 'Rua Futebol, 2024', 'kane@futi.com', '16998951983'),
('Jaqueline', 'Carvalho', '2001-12-10', 'Rua Volei, 456', 'jack@volei.com', '16991993575'),
('Sheilla', 'Castro', '2003-04-25', 'Rua Volei, 2028', 'sheilla.castro@volei.com', '16981974547'),
('Gabriela', 'Guimarães', '2007-08-19', 'Rua Volei, 2028', 'gaby@volei.com', '16983932215'),
('Magic', 'Johnson', '2003-07-08', 'Rua NBA, 1999', 'magic@gmail.com', '16993932020'),
('Camila', 'Almeida', '2005-08-16', 'Rua contente, 101', 'cami@gmail.com','16991211221'),
('Taby', 'Lorenzato', '2008-04-01', 'Rua Hallowen, 666', 'taby.lo@gmail.com', '16991614133'),
('Maik', 'Miller', '2009-02-23', 'Rua Porto, 61', 'maik@email.com', '16994657013'),
('Saliver', 'Oscar', '2001-06-22', 'Rua Halkins, 1098', 'saliver.o@email.com', '16995725802'),
('Isadora', 'Alencar','2007-06-30', 'Rua Aparecida do Norte, 123', 'isa@gmail.com', '16992231888'),
('Cacau', 'Moura', '2000-10-06', 'Rua Natalina, 267', 'cacau.moura@email.com', '16994673241'),
('Gabi', 'Turcato', '2005-07-13', 'Rua Sampaio,1814', 'turcato.gabi@email.com', '16993613102'),
('Tyller', 'Figueredo', '2009-02-23', 'Rua Salvador, 436', 'tyller@email.com', '16997345263'),
('Juju', 'Limeira', '2008-06-24', 'Rua Piratas, 543', 'juju2008@gmail.com', '16993327473'),
('Frank', 'Ramos', '2009-07-28', 'Rua Vila Lobos, 1345', 'frank123@gmail.com', '16993725108');
INSERT INTO Aluno (nome, sobrenome, data_nascimento, endereco, email, celular) 
VALUES 
('Lucas', 'Silva', '2004-02-15', 'Rua das Palmeiras, 120', 'lucas.silva@email.com', '(16) 98876-1122'),
('Mariana', 'Oliveira', '2003-09-21', 'Avenida Brasil, 875', 'mariana.oliveira@email.com', '(16) 99745-3344'),
('Pedro', 'Souza', '2005-06-10', 'Rua João Paulo II, 440', 'pedro.souza@email.com', '(16) 99213-5566'),
('Ana', 'Carvalho', '2002-11-09', 'Rua das Acácias, 211', 'ana.carvalho@email.com', '(16) 99134-7788'),
('Felipe', 'Costa', '2001-12-30', 'Rua São José, 98', 'felipe.costa@email.com', '(16) 99356-8899'),
('Camila', 'Mendes', '2003-04-17', 'Rua Bela Vista, 502', 'camila.mendes@email.com', '(16) 99542-2211'),
('Gustavo', 'Lima', '2004-08-05', 'Rua das Flores, 333', 'gustavo.lima@email.com', '(16) 99901-7733'),
('Isabela', 'Fernandes', '2002-03-28', 'Rua Dom Pedro, 150', 'isabela.fernandes@email.com', '(16) 98890-1144'),
('Thiago', 'Pereira', '2003-01-14', 'Avenida Paulista, 777', 'thiago.pereira@email.com', '(16) 98765-4422'),
('Larissa', 'Ribeiro', '2005-05-25', 'Rua Rio Branco, 230', 'larissa.ribeiro@email.com', '(16) 99432-2233');



-- LIVRO
INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'HarperCollins', '1954', '978-0007525546', 10, 10, 150.00, 'Disponível'),
('1984', 'George Orwell', 'Companhia das Letras', '1949', '978-8535906770', 8, 8, 90.00, 'Disponível'),
('Dom Quixote', 'Miguel de Cervantes', 'Penguin Classics', '1605', '978-0142437230', 6, 6, 120.00, 'Disponível'),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Agir', '1943', '978-8522008731', 12, 12, 50.00, 'Disponível'),
('A Revolução dos Bichos', 'George Orwell', 'Penguin', '1945', '978-0141036137', 7, 7, 80.00, 'Disponível'),
('O Hobbit', 'J.R.R. Tolkien', 'HarperCollins', '1937', '978-0007458424', 9, 9, 140.00, 'Disponível'),
('O Conde de Monte Cristo', 'Alexandre Dumas', 'Penguin Classics', '1844', '978-0140449266', 5, 5, 110.00, 'Disponível'),
('Orgulho e Preconceito', 'Jane Austen', 'Penguin Classics', '1813', '978-0141439518', 7, 7, 90.00, 'Disponível'),
('Moby Dick', 'Herman Melville', 'Penguin Classics', '1851', '978-0142437247', 4, 4, 100.00, 'Disponível'),
('Guerra e Paz', 'Liev Tolstói', 'Companhia das Letras', '1869', '978-8535922343', 3, 3, 130.00, 'Disponível'),
('A Menina que Roubava Livros', 'Markus Zusak', 'Intrínseca', 2005, '978-8535902771', 10, 10, 85.00, 'Disponível'),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Rocco', 1997, '978-8532511013', 12, 12, 120.00, 'Disponível'),
('O Código Da Vinci', 'Dan Brown', 'Arqueiro', 2003, '978-8599296578', 8, 8, 95.00, 'Disponível'),
('A Culpa é das Estrelas', 'John Green', 'Intrínseca', 2012, '978-8580572261', 9, 9, 70.00, 'Disponível'),
('O Morro dos Ventos Uivantes', 'Emily Brontë', 'Penguin Classics', 1847, '978-0141439556', 6, 6, 80.00, 'Disponível'),
('O Alquimista', 'Paulo Coelho', 'HarperOne', 1988, '978-0061122415', 10, 10, 60.00, 'Disponível'),
('It: A Coisa', 'Stephen King', 'Suma', 1986, '978-8532522330', 5, 5, 150.00, 'Disponível'),
('O Nome do Vento', 'Patrick Rothfuss', 'Arqueiro', 2007, '978-8599296493', 7, 7, 130.00, 'Disponível'),
('Coraline', 'Neil Gaiman', 'Rocco', 2002, '978-8532512065', 6, 6, 75.00, 'Disponível'),
('O Diário de Anne Frank', 'Anne Frank', 'Record', 1947, '978-8501044453', 8, 8, 90.00, 'Disponível');

INSERT INTO Livro (titulo, autor, editora, ano_publicacao, isbn, quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado) 
VALUES 
('A Culpa é das Estrelas', 'John Green', 'Intrínseca', '2012', '978-8580572261', 10, 10, 80.00, 'Disponível'),
('Os Miseráveis', 'Victor Hugo', 'Martin Claret', '1862', '978-8572328406', 8, 8, 120.00, 'Disponível'),
('O Código Da Vinci', 'Dan Brown', 'Arqueiro', '2003', '978-8575421135', 7, 7, 95.00, 'Disponível'),
('A Menina que Roubava Livros', 'Markus Zusak', 'Intrínseca', '2005', '978-8535902772', 9, 9, 85.00, 'Disponível'),
('Percy Jackson e o Ladrão de Raios', 'Rick Riordan', 'Intrínseca', '2005', '978-8598078355', 12, 12, 75.00, 'Disponível'),
('O Alquimista', 'Paulo Coelho', 'Rocco', '1988', '978-8579800240', 10, 10, 60.00, 'Disponível'),
('A Seleção', 'Kiera Cass', 'Seguinte', '2012', '978-8565765015', 6, 6, 70.00, 'Disponível'),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Rocco', '1997', '978-8532511014', 15, 15, 100.00, 'Disponível'),
('Cidades de Papel', 'John Green', 'Intrínseca', '2008', '978-8580573954', 9, 9, 80.00, 'Disponível'),
('O Diário de Anne Frank', 'Anne Frank', 'Record', '1947', '978-8501044457', 5, 5, 90.00, 'Disponível');


-- Inserindo Emprestimos
INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(1, 2, '2024-09-01', '2024-09-15', 'Em andamento'),
(2, 1, '2024-09-02', '2024-09-16', 'Em andamento'),
(3, 5, '2024-09-03', '2024-09-17', 'Em andamento'),
(5, 3, '2024-09-04', '2024-09-18', 'Em andamento'),
(4, 6, '2024-09-05', '2024-09-19', 'Em andamento'),
(6, 4, '2024-09-06', '2024-09-20', 'Em andamento'),
(7, 8, '2024-09-07', '2024-09-21', 'Em andamento'),
(8, 7, '2024-09-08', '2024-09-22', 'Em andamento'),
(10, 9, '2024-09-09', '2024-09-23', 'Em andamento'),
(9, 10, '2024-09-10', '2024-09-24', 'Em andamento'),
(11, 12, '2024-09-11', '2024-09-25', 'Em andamento'),
(13, 14, '2024-09-11', '2024-09-25', 'Em andamento'),
(15, 16, '2024-09-11', '2024-09-25', 'Em andamento'),
(17, 18, '2024-09-11', '2024-09-25', 'Em andamento'),
(19, 20, '2024-10-01', '2024-10-15', 'Em andamento'),
(12, 13, '2024-10-02', '2024-10-16', 'Em andamento'),
(18, 11, '2024-10-03', '2024-10-17', 'Em andamento'),
(17, 19, '2024-10-04', '2024-10-18', 'Em andamento'),
(14, 15, '2024-10-05', '2024-10-19', 'Em andamento'),
(20, 17, '2024-10-06', '2024-10-20', 'Em andamento'),
(16, 11, '2024-10-07', '2024-10-21', 'Em andamento'),
(20, 15, '2024-10-08', '2024-10-22', 'Em andamento'),
(13, 18, '2024-10-09', '2024-10-23', 'Em andamento'),
(19, 11, '2024-10-10', '2024-10-24', 'Em andamento');

INSERT INTO Emprestimo (id_aluno, id_livro, data_emprestimo, data_devolucao, status_emprestimo) 
VALUES 
(1, 3, '2025-10-01', '2025-10-15', 'Concluído'),
(2, 5, '2025-10-02', '2025-10-16', 'Concluído'),
(3, 7, '2025-10-03', '2025-10-17', 'Em andamento'),
(4, 1, '2025-10-04', '2025-10-18', 'Em andamento'),
(5, 9, '2025-10-05', '2025-10-19', 'Concluído'),
(6, 2, '2025-10-06', '2025-10-20', 'Em andamento'),
(7, 10, '2025-10-07', '2025-10-21', 'Em andamento'),
(8, 6, '2025-10-08', '2025-10-22', 'Concluído'),
(9, 4, '2025-10-09', '2025-10-23', 'Em andamento'),
(10, 8, '2025-10-10', '2025-10-24', 'Concluído');


