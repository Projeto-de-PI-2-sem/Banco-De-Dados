create database IF NOT EXISTS notelog;
-- drop database notelog;
use notelog;

-- Criar tabela Empresa
CREATE TABLE IF NOT EXISTS Empresa (
	id INT PRIMARY KEY,
	nome VARCHAR(90)
);

INSERT IGNORE INTO Empresa VALUES 
(null, 'Empresa');

-- Criar tabela Funcionario
CREATE TABLE IF NOT EXISTS Funcionario (
    id INT PRIMARY KEY,
    nome VARCHAR(90),
    cargo CHAR(90),
    email VARCHAR(90),
    senha VARCHAR(90),
    fkEmpresa INT,
    CONSTRAINT FK_Funcionario_Empresa FOREIGN KEY (fkEmpresa)
	REFERENCES Empresa(id) ON DELETE CASCADE
);

-- Criar tabela Notebook
CREATE TABLE IF NOT EXISTS Notebook (
	id INT PRIMARY Key,
	sistemaOperacional VARCHAR(90),
	fabricante VARCHAR(90),
	arquitetura VARCHAR(90),
    numeroSerial VARCHAR(180),
	fkFuncionario INT,
	fkEmpresa INT,
	CONSTRAINT FK_Notebook_Funcionario FOREIGN KEY (fkFuncionario)
	REFERENCES Funcionario (id) ON DELETE SET NULL,
	CONSTRAINT FK_Notebook_Empresa FOREIGN KEY (fkEmpresa)
	REFERENCES Empresa (id) ON DELETE CASCADE
);


-- Criar tabela CPU
CREATE TABLE IF NOT EXISTS `Cpu` (
	id INT PRIMARY KEY,
	fkNotebook INT,
	nome VARCHAR(90),
	numeroFisico VARCHAR(90),
	numerologico VARCHAR(90),
	idFisicoProcessador VARCHAR(90),
	frequencia VARCHAR(90),
	CONSTRAINT FK_Cpu_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

-- Criar tabela LogCPU
CREATE TABLE IF NOT EXISTS LogCpu (
	id INT PRIMARY KEY,
	fkCpu INT,
	porcentagemUso VARCHAR(90),
	dataLog datetime,
	CONSTRAINT FK_LogCpu_Cpu FOREIGN KEY (fkCpu)
	REFERENCES `Cpu` (id) ON DELETE CASCADE
);

-- Criar tabela LogJanelas
CREATE TABLE IF NOT EXISTS LogJanelas (
	id INT PRIMARY KEY,
	idJanela VARCHAR(90),
	nomeJanela VARCHAR(200),
    bloqueado BOOLEAN,
	fkNotebook INT,
	CONSTRAINT FK_LogJanelas_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

-- Criar tabela Disco
CREATE TABLE IF NOT EXISTS DiscoRigido (
	id INT PRIMARY KEY,
	fkNotebook INT,
	modelo VARCHAR(135),
	`serial` VARCHAR(90),
	tamanho VARCHAR(90),
	CONSTRAINT FK_DiscoRigido_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

-- Criar tabela LogDisco
CREATE TABLE IF NOT EXISTS LogDisco (
	id INT PRIMARY KEY ,
	fkDiscoRigido int,
	usoDisco varchar(64),
	dataLog datetime,
	CONSTRAINT FK_LogDisco_DiscoRigido FOREIGN KEY (fkDiscoRigido)
	REFERENCES DiscoRigido (id) ON DELETE CASCADE
);
    
-- Criando tabela TempoDeAtividade
CREATE TABLE IF NOT EXISTS TempoDeAtividade (
	id INT PRIMARY KEY,
	fkNotebook INT,
	tempoDeAtividade VARCHAR(90),
	tempoInicializado VARCHAR(90),
	CONSTRAINT FK_TempoDeAtividade_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

	-- Criando tabela Ram
CREATE TABLE IF NOT EXISTS Ram (
	id INT PRIMARY KEY,
	fkNotebook INT,
	totalMemoria varchar(90),
	CONSTRAINT FK_Ram_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
	);
    
-- Criando tabela LogRAM
CREATE TABLE IF NOT EXISTS LogRam (
	id INT PRIMARY KEY,
	fkRam INT,
	usoMemoria VARCHAR(90),
	memoriaDisponivel VARCHAR(90),
	dataLog datetime,
	CONSTRAINT FK_LogRam_Ram FOREIGN KEY (fkRam)
	REFERENCES Ram (id) ON DELETE CASCADE
);

-- Criando tabela Geolocalizacao
CREATE TABLE IF NOT EXISTS Geolocalizacao (
    id INT PRIMARY KEY,
    fkNotebook INT,
    enderecoIP VARCHAR(90),
    pais VARCHAR(90),
    cidade VARCHAR(90),
    nomeRegiao VARCHAR(90),
    latitude VARCHAR(90),
    longitude VARCHAR(90),
    timeZone VARCHAR(12),
    companiaInternet VARCHAR(160),
    CONSTRAINT FK_Geolocalizacao_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);
    
    CREATE USER IF NOT EXISTS 'notelogUser'@'localhost' IDENTIFIED BY 'notelikeag0d*';
    
    GRANT SELECT, INSERT, UPDATE, DELETE ON notelog.* TO 'notelogUser'@'localhost';
    
    FLUSH PRIVILEGES;