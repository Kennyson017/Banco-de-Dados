CREATE TABLE Departamento (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Localizacao VARCHAR(255),
    PRIMARY KEY (Id)
);

CREATE TABLE Aluno (
    matricula VARCHAR(10) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    endereço VARCHAR(255),
    PRIMARY KEY (matricula)
);


CREATE TABLE Disciplina (
    nome VARCHAR(100) NOT NULL,
    carga_horaria int NOT NULL DEFAULT 30, -- 30, 45, 60, 90
    ementa text,

    PRIMARY KEY (nome)
);

CREATE TABLE Professor (
    data_inicio_Contrato DATE,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    depto_id int,

    PRIMARY KEY (cpf),
    FOREIGN KEY (depto_id) REFERENCES Departamento(id)
);

CREATE TABLE professor_contato (
    prof_cpf VARCHAR(11) NOT NULL,
    contato VARCHAR(14) NOT NUll,

    FOREIGN KEY (prof_cpf) REFERENCES professor(cpf),
    CONSTRAINT PK_professor_contato PRIMARY KEY (prof_cpf, contato)
);

CREATE TABLE Avaliacao (
    prof_cpf VARCHAR(11) NOT NULL,
    data_hora datetime NOT NULL,
    comentario VARCHAR(500),
    nota int, -- min e max?

    FOREIGN KEY (prof_cpf) REFERENCES professor(cpf),
    PRIMARY KEY (prof_cpf, data_hora)
);


-- FOREIGN KEYS indisponiveis na criação

ALTER TABLE Departamento
    ADD prof_chefe_cpf VARCHAR (11),
    ADD FOREIGN KEY (prof_chefe_cpf) REFERENCES professor(cpf);

ALTER TABLE Disciplina
    ADD disc_pre_requisito VARCHAR(100),
    ADD FOREIGN KEY (disc_pre_requisito) REFERENCES Disciplina(nome);

-- M:N 

CREATE TABLE aluno_disciplina (
   matricula VARCHAR(10) NOT NULL,
   nome VARCHAR(100) NOT NULL,

   PRIMARY KEY (matricula, nome),
   FOREIGN KEY (matricula) REFERENCES aluno(matricula),
   FOREIGN KEY (nome) REFERENCES Disciplina(nome)
);

CREATE TABLE professor_disciplina (
    cpf VARCHAR(11)  NOT NULL,
    nome VARCHAR(100) NOT NUll,

    PRIMARY KEY (cpf, nome),
    FOREIGN KEY (cpf) REFERENCES professor(cpf),
    FOREIGN key (nome) REFERENCES Disciplina(nome)
);


-- Inserindo 1 departamento, 5 alunos, 2 professores e 3 disciplinas

INSERT INTO departamento (nome, local) values ('Ciências Exatas', 'Belo Horizonte');

INSERT INTO aluno values
('Livia Silva', '1990-02-01', '1234567890', 'Rua A, 42'),
('Dorothy Vaughan', '1989-03-19', '2234567890', 'Rua B, 6'),
('Nina Silva', '1993-12-31', '3334567890', 'Rua C, 190'),
('Grace Hopper', '1992-10-20', '4444567890', 'Rua D, 70'),
('Margaret Hamilton', '1992-10-20', '5555567890', 'Rua E, 87');

INSERT INTO professor (inicio_contrato, nome, cpf) values
('2024-01-02', 'Hedy Lamarr', '12345678901'),
('2024-01-02', 'Ada Lovelace', '09876543212');

INSERT INTO disciplina values
( 'Introdução a programação', 30, 'A, B, C, D', NULL),
('Introdução a banco de dados', 45, 'X, Y, Z, W', NULL),
('Algoritmos e Estruturas de Dados', 60, 'F, G, H, I', 'Introdução a programação');

-- Professor 1. leciona duas disciplinas, professor 2 leciona uma disciplina
INSERT INTO professor_disciplina values
('12345678901', 'Introdução a programação'),
('12345678901', 'Introdução a banco de dados'),
('09876543212', 'Algoritmos e Estruturas de Dados');,

-- Todos os alunos fazem todas as disciplinas
INSERT INTO aluno_disciplina values
('1234567890', 'Introdução a programação'),
('2234567890', 'Introdução a programação'),
('3334567890', 'Introdução a programação'),
('4444567890', 'Introdução a programação'),
('5555567890', 'Introdução a programação'),
('1234567890' 'Introdução a banco de dados'),
('2234567890', 'Introdução a banco de dados'),
('3334567890', 'Introdução a banco de dados'),
('4444567890', 'Introdução a banco de dados'),
('5555567890', 'Introdução a banco de dados'),
('1234567890', 'Algoritmos e Estruturas de Dados'),
('2234567890', 'Algoritmos e Estruturas de Dados'),
('3334567890', 'Algoritmos e Estruturas de Dados'),
('4444567890', 'Algoritmos e Estruturas de Dados'),
('5555567890', 'Algoritmos e Estruturas de Dados');

-- Professor 1 é chefe do departamento
UPDATE departamento
SET prof_chefe_cpf = '12345678901'
WHERE id = 1;

-- Professor 2 recebeu duas avaliacoes
INSERT INTO avaliacao values
('09876543212', '2024-03-10 10:01:00', 'ótima didática', 10),
...('09876543212', '2024-05-04 10:01:01', 'muito prestativa', 9);


-- Adicionar professor contato
