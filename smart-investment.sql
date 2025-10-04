CREATE DATABASE smart_investment;
USE smart_investment;
SET foreign_key_checks = 0;

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(70) NOT NULL,
dtNascimento DATE,
email VARCHAR(60) NOT NULL UNIQUE,
senha VARCHAR(255) NOT NULL,
perfil VARCHAR(20),
	CONSTRAINT chkPerfil 
		CHECK (perfil IN ('Conservador', 'Moderado', 'Arrojado'))
);

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80) NOT NULL,
ticker VARCHAR(10) NOT NULL,
setor VARCHAR(30) NOT NULL,
logo VARCHAR(255)
);

CREATE TABLE acoes (
idAcoes INT PRIMARY KEY AUTO_INCREMENT,
dtAtual DATE NOT NULL,
precoAbertura DOUBLE NOT NULL,
precoFechamento DOUBLE NOT NULL,
precoMaisAlto DOUBLE NOT NULL,
precoMaisBaixo DOUBLE NOT NULL,
volume DOUBLE NOT NULL,
fkEmpresa INT,
CONSTRAINT fkAcoesEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE acoesFavoritadas (
idAcoesFavoritadas INT PRIMARY KEY AUTO_INCREMENT,
fkAcoes INT NOT NULL,
CONSTRAINT fkAcoesFavoritadas FOREIGN KEY (fkAcoes) REFERENCES acoes(idAcoes),
fkUsuario INT NOT NULL,
CONSTRAINT fkUsuarioAcoesFavoritadas FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE notificacoes (
idNotificacoes INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(30),
CONSTRAINT chkTipoNotificacoes
		CHECK (tipo IN ('Ação sugerida', 'Ação Favoritada', 'Alerta')),
mensagem VARCHAR(255),
fkAcoes INT NOT NULL,
CONSTRAINT fkAcoesNotificacoes FOREIGN KEY (fkAcoes) REFERENCES acoes(idAcoes),
fkUsuario INT NOT NULL,
CONSTRAINT fkUsuarioNotificacoes FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE log (
idLog INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR(255),
CONSTRAINT chkTipoLog
		CHECK (tipo IN ('Sucesso', 'Alerta', 'Erro')),
dtLog DATETIME NOT NULL,
mensagemErro VARCHAR(80)
);

-- INSERT INTO usuario (nome, dtNascimento, email, senha, perfil) VALUES
-- ('Juliana Santos', '1990-05-12', 'juliana.santos@email.com', 'senha123', 'Conservador'),
-- ('Bruno Cordeiro', '1985-09-23', 'bruno.cordeiro@email.com', 'senha123', 'Moderado'),
-- ('Carla Menezes', '1998-02-15', 'carla.menezes@email.com', 'senha123', 'Arrojado');

-- INSERT INTO empresa (nome, ticker, setor, logo) VALUES
-- ('Vale S.A.', 'VALE3', 'Mineração', 'vale_logo.png'),
-- ('Petrobras', 'PETR4', 'Energia', 'petrobras_logo.png'),
-- ('Itaú Unibanco', 'ITUB4', 'Financeiro', 'itau_logo.png');

-- INSERT INTO acoes (
--  dtAtual, precoAbertura, precoFechamento, precoMaisAlto, precoMaisBaixo, volume, ticker, fkEmpresa
-- ) VALUES (
--  '2025-09-30', 65.20, 66.50, 67.00, 64.90, 1000000, 'PETR4',
-- (SELECT idEmpresa FROM empresa WHERE ticker = 'PETR4')
-- );

-- ('2025-09-30', 34.10, 35.00, 35.50, 33.80, 2500000, 2), 
-- ('2025-09-30', 28.00, 27.50, 28.40, 27.30, 1800000, 3);

-- INSERT INTO acoesFavoritadas (fkAcoes, fkUsuario) VALUES
-- (1, 1),
-- (2, 2),
-- (3, 3);

-- INSERT INTO notificacoes (tipo, mensagem, fkAcoes, fkUsuario) VALUES
-- ('Ação sugerida', 'Vale é indicada para perfil conservador esta semana.', 1, 1),
-- ('Alerta', 'Petrobras atingiu queda de 5% hoje.', 2, 2),
-- ('Ação Favoritada', 'Itaú foi favoritada com sucesso.', 3, 3);

-- INSERT INTO log (tipo, dtLog, mensagemErro) VALUES
-- ('Sucesso', NOW(), 'Usuário cadastrou ação favorita'),
-- ('Alerta', NOW(), 'Petrobras caiu 5% em um dia'),
-- ('Erro', NOW(), 'Falha ao enviar notificação por e-mail');

/* CREATE VIEW dados AS
SELECT
    -- usuário
    u.idUsuario,
    u.nome AS nomeUsuario,
    u.dtNascimento,
    u.email,
    u.perfil,
    -- empresa
    e.idEmpresa,
    e.nome AS nomeEmpresa,
    e.ticker,
    e.setor,
    e.logo,
    -- ações
    a.idAcoes,
    a.dtAtual,
    a.precoAbertura,
    a.precoFechamento,
    a.precoMaisAlto,
    a.precoMaisBaixo,
    a.volume,
    a.fkEmpresa,
    -- ações favoritadas
    af.idAcoesFavoritadas,
    af.fkAcoes AS acaoFavoritada,
    af.fkUsuario AS usuarioFavoritou,
    -- notificações
    n.idNotificacoes,
    n.tipo AS tipoNotificacao,
    n.mensagem AS mensagemNotificacao,
    n.fkAcoes AS notificacaoAcao,
    n.fkUsuario AS notificacaoUsuario,
    -- log 
    l.idLog,
    l.tipo AS tipoLog,
    l.dtLog,
    l.mensagemErro

FROM usuario u
LEFT JOIN acoesFavoritadas af ON u.idUsuario = af.fkUsuario
LEFT JOIN acoes a ON af.fkAcoes = a.idAcoes
LEFT JOIN empresa e ON a.fkEmpresa = e.idEmpresa
LEFT JOIN notificacoes n ON u.idUsuario = n.fkUsuario
LEFT JOIN log l ON l.dtLog = (
    SELECT MAX(l2.dtLog) FROM log l2
);

-- SELECT * FROM dados;
SELECT * FROM empresa order by ticker asc;
SELECT * FROM empresa;
SELECT * FROM acoes;
SELECT * FROM log;

SELECT COUNT(*) FROM acoes;


 



-- select* FROM acoes order by dtAtual desc;
truncate table empresa ; */




