	create database Notelog;

	use Notelog;

	-- Criar tabela Empresa
	CREATE TABLE Empresa (
		id INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(45),
		cnpj CHAR(18),
		email VARCHAR(45)
	);

	-- Criar tabela Usuário
	CREATE TABLE Usuario (
		id INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(45),
		senha VARCHAR(10),
		fkEmpresa INT,
		CONSTRAINT FK_Usuario_Empresa FOREIGN KEY (fkEmpresa)
			REFERENCES Empresa(id)
	);

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

	-- Criar tabela Funcionario
	CREATE TABLE Funcionario (
		id INT AUTO_INCREMENT,
		fkUsuario INT,
		fkUsuarioEmpresa INT,
		primary key (id, fkUsuario, fkUsuarioEmpresa),
		nome VARCHAR(45),
		cargo CHAR(11),
		email VARCHAR(45),
		fkEmpresa INT,
		CONSTRAINT FK_Funcionario_Empresa FOREIGN KEY (fkEmpresa)
			REFERENCES Empresa(id),
		CONSTRAINT FK_Funcionario_Usuario FOREIGN KEY (fkUsuario)
			REFERENCES Usuario(id),
		CONSTRAINT FK_Funcionario_Usuario_Empresa FOREIGN KEY (fkUsuarioEmpresa)
			REFERENCES Usuario(fkEmpresa)
	);

	-- Criar tabela Notebook
	CREATE TABLE Notebook (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  sistemaOperacional VARCHAR(45),
	  fabricante VARCHAR(45),
	  arquitetura VARCHAR(45),
	  fkFuncionario INT,
	  CONSTRAINT FK_Notebook_Funcionario FOREIGN KEY (fkFuncionario)
			REFERENCES Funcionario (id)
	);

	-- Criar tabela CPU
	CREATE TABLE `cpu` (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  nome VARCHAR(45),
	  numeroFisico VARCHAR(45),
	  numerologico VARCHAR(45),
	  idFisicoProcessador VARCHAR(45),
	  frequencia VARCHAR(45)
	);

	-- Criar tabela LogCPU
	CREATE TABLE LogCpu (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  fkCpu INT,
	  porcentagemUso VARCHAR(45),
	  CONSTRAINT FK_LogCpu_Cpu FOREIGN KEY (fkCpu)
		REFERENCES `cpu` (id)
	);

	-- Criar tabela LogJanelas
	CREATE TABLE LogJanelas (
	  id INT AUTO_INCREMENT PRIMARY KEY,
	  enderecoJanela VARCHAR(45),
	  fkNotebook INT,
	  CONSTRAINT FK_LogJanelas_Notebook FOREIGN KEY (fkNotebook)
		REFERENCES Notebook (id)
	);

	-- Criar tabela Disco
	CREATE TABLE DiscoRigido (
		id INT AUTO_INCREMENT PRIMARY KEY,
		modelo VARCHAR(45),
		`serial` VARCHAR(45),
		tamanho VARCHAR(45)
	);

	-- Criar tabela LogDisco
	CREATE TABLE LogDiscos (
		id INT AUTO_INCREMENT,
		fkDiscos INT,
		fkNotebook INT,
		primary key (id),
		-- fkDiscoRigido, fkNotebook
		leituras VARCHAR(45),
		bytesLeitura VARCHAR(45),
		escritas VARCHAR(45),
		bytesEscritas VARCHAR(45),
		CONSTRAINT FK_LogDisco_Notebook FOREIGN KEY (fkNotebook)
			REFERENCES Notebook (id),
		CONSTRAINT FK_LogDisco_DiscoRgido FOREIGN KEY (fkDiscoRigido)
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
	CREATE TABLE ram (
		id INT PRIMARY KEY AUTO_INCREMENT,
		totalMemoria varchar(45)
	);

	-- Criando tabela LogRAM
	CREATE TABLE LogRam (
		id INT AUTO_INCREMENT,
		fkNotebook INT,
		fkRam INT,
		primary key(id),
		-- fkNotebook, fkRAM
		usoMemoria VARCHAR(45),
		memoriaDisponivel VARCHAR(45),
		CONSTRAINT FK_LogRam_Notebook FOREIGN KEY (fkNotebook)
			REFERENCES Notebook (id),
		CONSTRAINT FK_LogRam_Ram FOREIGN KEY (fkRam)
			REFERENCES ram (id)
	);

	-- Criando tabela Geolocalizacao
	CREATE TABLE Geolocalizacao (
	  id INT AUTO_INCREMENT,
	  fkNotebook INT,
	  primary key(id),
	  -- fkNotebook
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