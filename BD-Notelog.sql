create database notelog;
-- drop database notelog;
use notelog;

-- Criar tabela Empresa
CREATE TABLE Empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(90),
	cnpj CHAR(18),
	email VARCHAR(90),
	webHookUrl VARCHAR (350),
	oAuthToken VARCHAR (350),
	slackChannel VARCHAR (90)
);

-- Procurar o insert das empresas no Google driver do banco,
-- Eles possuem tokens do Slack, que não podem ser enviados para o Github.
-- tá no driver da conta da infraview. :)

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
	REFERENCES Empresa(id) ON DELETE CASCADE
);

-- Criar tabela Funcionario
CREATE TABLE Funcionario (
    id INT PRIMARY KEY,
    nome VARCHAR(90),
    cargo CHAR(90),
    email VARCHAR(90),
    senha VARCHAR(90),
    fkEmpresa INT,
    CONSTRAINT FK_Funcionario_Empresa FOREIGN KEY (fkEmpresa)
	REFERENCES Empresa(id) ON DELETE CASCADE
);

    
-- Usuários para Moveis S.A
INSERT INTO Funcionario (id,nome, cargo, email, senha, fkEmpresa) VALUES
(1,'Jozias Duarte', 'Gerente', 'joao@moveissa.com', 'senha123', 1),
(2,'Ana Pimpolim', 'Técnico', 'ana@solutionsburnit.com', 'solutions456', 2),
(3,'Camila da Silva', 'Desenvolvedor', 'camila@infratech.com', 'infra789', 3),
(4,'Henrique de Moraes', 'Dev', 'joao@moveissa.com', null,1),
(5,'Gislayno de Almeida', 'QA', 'ana@solutionsburnit.com', null,2),
(6,'Zazaleu de Bezerra', 'Dev', 'camila@infratech.com', null,3);

-- Criar tabela Notebook
CREATE TABLE Notebook (
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
CREATE TABLE `Cpu` (
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
CREATE TABLE LogCpu (
	id INT PRIMARY KEY,
	fkCpu INT,
	porcentagemUso VARCHAR(90),
	dataLog datetime,
	CONSTRAINT FK_LogCpu_Cpu FOREIGN KEY (fkCpu)
	REFERENCES `Cpu` (id) ON DELETE CASCADE
);

-- Criar tabela LogJanelas
CREATE TABLE LogJanelas (
	id INT PRIMARY KEY,
	idJanela VARCHAR(90),
	nomeJanela VARCHAR(200),
    bloqueado BOOLEAN,
	fkNotebook INT,
	CONSTRAINT FK_LogJanelas_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

-- Criar tabela Disco
CREATE TABLE DiscoRigido (
	id INT PRIMARY KEY,
	fkNotebook INT,
	modelo VARCHAR(135),
	`serial` VARCHAR(90),
	tamanho VARCHAR(90),
	CONSTRAINT FK_DiscoRigido_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

-- Criar tabela LogDisco
CREATE TABLE LogDisco (
	id INT PRIMARY KEY ,
	fkDiscoRigido int,
	usoDisco varchar(64),
	dataLog datetime,
	CONSTRAINT FK_LogDisco_DiscoRigido FOREIGN KEY (fkDiscoRigido)
	REFERENCES DiscoRigido (id) ON DELETE CASCADE
);

SELECT id FROM LogDisco WHERE fkDiscoRigido = 1 ORDER BY id DESC LIMIT 1;
    
-- Criando tabela TempoDeAtividade
CREATE TABLE TempoDeAtividade (
	id INT PRIMARY KEY,
	fkNotebook INT,
	tempoDeAtividade VARCHAR(90),
	tempoInicializado VARCHAR(90),
	CONSTRAINT FK_TempoDeAtividade_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
);

	-- Criando tabela Ram
CREATE TABLE Ram (
	id INT PRIMARY KEY,
	fkNotebook INT,
	totalMemoria varchar(90),
	CONSTRAINT FK_Ram_Notebook FOREIGN KEY (fkNotebook)
	REFERENCES Notebook (id) ON DELETE CASCADE
	);
    
-- Criando tabela LogRAM
CREATE TABLE LogRam (
	id INT PRIMARY KEY,
	fkRam INT,
	usoMemoria VARCHAR(90),
	memoriaDisponivel VARCHAR(90),
	dataLog datetime,
	CONSTRAINT FK_LogRam_Ram FOREIGN KEY (fkRam)
	REFERENCES Ram (id) ON DELETE CASCADE
);

-- Criando tabela Geolocalizacao
CREATE TABLE Geolocalizacao (
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
)
;
    
    CREATE USER 'notelogUser'@'localhost' IDENTIFIED BY 'notelikeag0d*';
    
    GRANT SELECT, INSERT, UPDATE, DELETE ON notelog.* TO 'notelogUser'@'localhost';
    
    FLUSH PRIVILEGES;
-- select * from Empresa;
-- select * from funcionario;
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
-- select DiscoRigido.tamanho from DiscoRigido;
-- select * from Funcionario where fkEmpresa = 3;
-- update TempoDeAtividade set tempoDeAtividade = 3 where tempoInicializado = '2024-05-10T12:33:59Z' AND fkNotebook = 1;
-- SELECT id from Ram ORDER BY id DESC LIMIT 1;

