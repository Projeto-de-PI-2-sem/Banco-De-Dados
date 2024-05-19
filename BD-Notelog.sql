create database notelog;
-- drop database notelog;
use notelog;

	-- Criar tabela Empresa
	CREATE TABLE Empresa (
		id INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(45),
		cnpj CHAR(18),
		email VARCHAR(45)
	);
    
INSERT INTO Empresa (nome,CNPJ, email) VALUES 
('Moveis S.A','08.540.322/0001-35','moveissa@gmail.com'),
('SolutionsBurn IT','65.719.677/0001-20','solutionsburnit@gmail.com'),
('InfraTech','26.897.566/0001-51','infratech@gmail.com');


	-- Criar tabela Funcionario
CREATE TABLE Funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cargo CHAR(45),
    email VARCHAR(45),
    senha VARCHAR(45),
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
		bairro VARCHAR(45),
		rua VARCHAR(45),
		estado VARCHAR(45),
		numero VARCHAR(45),
		complemento VARCHAR(45),
		cep CHAR(8),
		fkEmpresa INT,
		CONSTRAINT FK_Endereco_Empresa FOREIGN KEY (fkEmpresa)
			REFERENCES Empresa(id)
	);

	-- Criar tabela Notebook
	CREATE TABLE Notebook (
	  id INT AUTO_INCREMENT,
	  sistemaOperacional VARCHAR(45),
	  fabricante VARCHAR(45),
	  arquitetura VARCHAR(45),
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
	  nome VARCHAR(45),
	  numeroFisico VARCHAR(45),
	  numerologico VARCHAR(45),
	  idFisicoProcessador VARCHAR(45),
	  frequencia VARCHAR(45),
	  CONSTRAINT FK_Cpu_Notebook FOREIGN KEY (fkNotebook)
		REFERENCES Notebook (id)
	);

	-- Criar tabela LogCPU
	CREATE TABLE LogCpu (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  fkCpu INT,
	  porcentagemUso VARCHAR(45),
      dataLog datetime,
	  CONSTRAINT FK_LogCpu_Cpu FOREIGN KEY (fkCpu)
		REFERENCES `Cpu` (id)
	);

	-- Criar tabela LogJanelas
	CREATE TABLE LogJanelas (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  idJanela VARCHAR(45),
	  fkNotebook INT,
	  dataLog datetime,
	  CONSTRAINT FK_LogJanelas_Notebook FOREIGN KEY (fkNotebook)
		REFERENCES Notebook (id)
	);

	-- Criar tabela Disco
	CREATE TABLE DiscoRigido (
		id INT AUTO_INCREMENT PRIMARY KEY,
        fkNotebook INT,
		modelo VARCHAR(45),
		`serial` VARCHAR(45),
		tamanho VARCHAR(45),
        dataLog datetime,
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
		tempoDeAtividade VARCHAR(45),
		tempoInicializado VARCHAR(45),
		CONSTRAINT FK_TempoDeAtividade_Notebook FOREIGN KEY (fkNotebook)
			REFERENCES Notebook (id)
	);

	-- Criando tabela Ram
	CREATE TABLE Ram (
		id INT PRIMARY KEY AUTO_INCREMENT,
        fkNotebook INT,
		totalMemoria varchar(45),
	  CONSTRAINT FK_Ram_Notebook FOREIGN KEY (fkNotebook)
		REFERENCES Notebook (id)
	);

	-- Criando tabela LogRAM
	CREATE TABLE LogRam (
		id INT AUTO_INCREMENT PRIMARY KEY,
		fkRam INT,
		usoMemoria VARCHAR(45),
		memoriaDisponivel VARCHAR(45),
        dataLog datetime,
		CONSTRAINT FK_LogRam_Ram FOREIGN KEY (fkRam)
			REFERENCES Ram (id)
	);

	-- Criando tabela Geolocalizacao
	CREATE TABLE Geolocalizacao (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  fkNotebook INT,
	  enderecoIP VARCHAR(45),
	  pais VARCHAR(45),
	  cidade VARCHAR(45),
	  nomeRegiao VARCHAR(45),
	  latitude VARCHAR(45),
	  longitude VARCHAR(45),
	  timeZone VARCHAR(6),
	  companiaInternet VARCHAR(45),
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
-- select * from `Cpu` join LogCpu on `Cpu`.id = fkCpu;
-- select * from DiscoRigido;
-- select * from Funcionario;
-- update TempoDeAtividade set tempoDeAtividade = 3 where tempoInicializado = '2024-05-10T12:33:59Z' AND fkNotebook = 1;
-- SELECT id from Ram ORDER BY id DESC LIMIT 1;