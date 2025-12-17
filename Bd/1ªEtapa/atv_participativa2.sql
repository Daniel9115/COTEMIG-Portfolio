-- Q1
CREATE DATABASE bancodeteste;
USE bancodeteste;

CREATE TABLE Pessoa (
    idPessoa INT PRIMARY KEY,
    nome VARCHAR(255),
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    idEstado INT,
    cep INT
);

CREATE TABLE Carro (
    idCarro INT PRIMARY KEY,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    cor VARCHAR(50),
    placa VARCHAR(20),
    chassi VARCHAR(50)
);

--Q3
CREATE TABLE Carro (
    idCarro INT PRIMARY KEY,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    cor VARCHAR(50),
    placa VARCHAR(20),
    chassi VARCHAR(50),
    idPessoa INT,
    FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
);
