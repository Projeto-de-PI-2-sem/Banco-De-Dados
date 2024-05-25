create database notelog;
-- drop database notelog;
use notelog;

	-- Criar tabela Empresa
	CREATE TABLE Empresa (
		id INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(90),
		cnpj CHAR(18),
		email VARCHAR(90)
	);
    
INSERT INTO Empresa (nome,CNPJ, email) VALUES 
('Moveis S.A','08.540.322/0001-35','moveissa@gmail.com'),
('SolutionsBurn IT','65.719.677/0001-20','solutionsburnit@gmail.com'),
('InfraTech','26.897.566/0001-51','infratech@gmail.com');


	-- Criar tabela Funcionario
CREATE TABLE Funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(90),
    cargo CHAR(90),
    email VARCHAR(90),
    senha VARCHAR(90),
    fkEmpresa INT,
    CONSTRAINT FK_Funcionario_Empresa FOREIGN KEY (fkEmpresa)
        REFERENCES Empresa(id)
);
    
    -- Usuários para Moveis S.A
INSERT INTO Funcionario (nome, cargo, email, senha, fkEmpresa) VALUES
('Jozias Duarte', 'Gerente', 'joao@moveissa.com', 'senha123', 1),
('Ana Pimpolim', 'Técnico', 'ana@solutionsburnit.com', 'solutions456', 2),
('Camila da Silva', 'Desenvolvedor', 'camila@infratech.com', 'infra789', 3),
('Henrique de Moraes', 'Dev', 'joao@moveissa.com', null,1),
('Gislayno de Almeida', 'QA', 'ana@solutionsburnit.com', null,2),
('Zazaleu de Bezerra', 'Dev', 'camila@infratech.com', null,3);

	-- Criar tabela Endereco
	CREATE TABLE Endereco (
		id INT PRIMARY KEY AUTO_INCREMENT,
		bairro VARCHAR(90),
		rua VARCHAR(90),
		estado VARCHAR(90),
		numero VARCHAR(90),
		complemento VARCHAR(90),
		cep VARCHAR(45),
		fkEmpresa INT,
		CONSTRAINT FK_Endereco_Empresa FOREIGN KEY (fkEmpresa)
			REFERENCES Empresa(id)
	);

	-- Criar tabela Notebook
CREATE TABLE Notebook (
	id INT AUTO_INCREMENT,
	sistemaOperacional VARCHAR(90),
	fabricante VARCHAR(90),
	arquitetura VARCHAR(90),
    numeroSerial VARCHAR(180),
	fkFuncionario INT,
	fkEmpresa INT,
	CONSTRAINT FK_Notebook_Funcionario FOREIGN KEY (fkFuncionario)
		REFERENCES Funcionario (id),
	CONSTRAINT FK_Notebook_Empresa FOREIGN KEY (fkEmpresa)
		REFERENCES Empresa (id),
	PRIMARY KEY(id, fkEmpresa)
);


-- Criar tabela CPU
CREATE TABLE `Cpu` (
	id INT AUTO_INCREMENT PRIMARY KEY,
	fkNotebook INT,
	nome VARCHAR(90),
	numeroFisico VARCHAR(90),
	numerologico VARCHAR(90),
	idFisicoProcessador VARCHAR(90),
	frequencia VARCHAR(90),
	CONSTRAINT FK_Cpu_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id)
);

	-- Criar tabela LogCPU
CREATE TABLE LogCpu (
	id INT AUTO_INCREMENT PRIMARY KEY,
	fkCpu INT,
	porcentagemUso VARCHAR(90),
	dataLog datetime,
	CONSTRAINT FK_LogCpu_Cpu FOREIGN KEY (fkCpu)
	REFERENCES `Cpu` (id)
);

	-- Criar tabela LogJanelas
CREATE TABLE LogJanelas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	idJanela VARCHAR(90),
	nomeJanela VARCHAR(200),
    bloqueado BOOLEAN,
	fkNotebook INT,
	CONSTRAINT FK_LogJanelas_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id)
);

-- Criar tabela Disco
CREATE TABLE DiscoRigido (
	id INT AUTO_INCREMENT PRIMARY KEY,
	fkNotebook INT,
	modelo VARCHAR(135),
	`serial` VARCHAR(90),
	tamanho VARCHAR(90),
	CONSTRAINT FK_DiscoRigido_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id)
);

-- Criar tabela LogDisco
	CREATE TABLE LogDisco (
		id INT AUTO_INCREMENT PRIMARY KEY,
		fkDiscoRigido int,
		leitura VARCHAR(45),
		bytesLeitura VARCHAR(45),
		escrita VARCHAR(45),
		bytesEscrita VARCHAR(45),
        dataLog datetime,
		CONSTRAINT FK_LogDisco_DiscoRigido FOREIGN KEY (fkDiscoRigido)
			REFERENCES DiscoRigido (id)
	);
    
-- Criando tabela TempoDeAtividade
CREATE TABLE TempoDeAtividade (
	id INT PRIMARY KEY AUTO_INCREMENT,
	fkNotebook INT,
	tempoDeAtividade VARCHAR(90),
	tempoInicializado VARCHAR(90),
	CONSTRAINT FK_TempoDeAtividade_Notebook FOREIGN KEY (fkNotebook)
		REFERENCES Notebook (id)
);

	-- Criando tabela Ram
	CREATE TABLE Ram (
		id INT PRIMARY KEY AUTO_INCREMENT,
        fkNotebook INT,
		totalMemoria varchar(90),
	  CONSTRAINT FK_Ram_Notebook FOREIGN KEY (fkNotebook)
		REFERENCES Notebook (id)
	);
	-- Criando tabela LogRAM
	CREATE TABLE LogRam (
		id INT AUTO_INCREMENT PRIMARY KEY,
		fkRam INT,
		usoMemoria VARCHAR(90),
		memoriaDisponivel VARCHAR(90),
        dataLog datetime,
		CONSTRAINT FK_LogRam_Ram FOREIGN KEY (fkRam)
			REFERENCES Ram (id)
	);

	-- Criando tabela Geolocalizacao
	CREATE TABLE Geolocalizacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
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
        REFERENCES Notebook (id)
);

    
    CREATE USER 'notelogUser'@'localhost' IDENTIFIED BY 'notelikeagod';
    
    GRANT SELECT, INSERT, UPDATE, DELETE ON notelog.* TO 'notelogUser'@'localhost';
    
    FLUSH PRIVILEGES;
-- select * from Geolocalizacao;
-- select * from Notebook;	
-- select * from TempoDeAtividade;
-- select * from Ram;
-- select * from DiscoRigido;
-- select * from LogRam;
-- select * from LogDisco;
-- select * from LogJanelas;
-- select * from LogCpu;
-- select * from Ram join LogRam on Ram.id = fkRam;
-- select * from `Cpu`;
-- select * from DiscoRigido;
-- select * from Funcionario;
-- update TempoDeAtividade set tempoDeAtividade = 3 where tempoInicializado = '2024-05-10T12:33:59Z' AND fkNotebook = 1;
-- SELECT id from Ram ORDER BY id DESC LIMIT 1;