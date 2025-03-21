-- BANCO DE DADOS LABORATÓRIO PCR FEITO POR HELENA GARBIN, JOÃO BARBOSA, MARINA ACOSTA E NICOLE REDMANN

-- CRIAÇÃO DO BANCO DE DADOS
DROP SCHEMA IF EXISTS laboratoriopcr;
CREATE SCHEMA laboratoriopcr;
USE laboratoriopcr;

-- CRIAÇÃO DA TABELA PESQUISADORES QUE ANALISARAM O PCR COM SUAS IDENTIFICAÇÕES PARA CONTROLE E REGISTRO DA EQUIPE QUE FAZ AS ANÁLISES
CREATE TABLE Pesquisadores (
    pesquisador_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- CRIAÇÃO DA TABELA DE AMOSTRAS DE PCR QUE SERÃO ANALISADAS COM IDENTIFICAÇÃO DELAS, QUANDO E COMO SERÃO ANALISADAS, E POR QUEM
-- PARA MELHOR CONTROLE DAS ANÁLISES DE PCR E DIAGNÓSTICO PRECISO DOS PACIENTES COM SARSCOV-2
CREATE TABLE Amostras_PCR (
    identificacao VARCHAR(100) PRIMARY KEY NOT NULL,
    data_coleta DATE NOT NULL,
    tipo_amostra VARCHAR(10) NOT NULL,
    pesquisador_id INTEGER,
    FOREIGN KEY (pesquisador_id) REFERENCES Pesquisadores(pesquisador_id)
);

-- CRIAÇÃO DA TABELA DO RELACIONAMENTO N:N ENTRE PESQUISADORES E AMOSTRAS 
CREATE TABLE Analisam (
	pesquisador_id INTEGER,
    identificacao VARCHAR(100),
    CONSTRAINT PK_ANALISAM PRIMARY KEY(pesquisador_id, identificacao),
    CONSTRAINT FOREIGN KEY(pesquisador_id) REFERENCES Pesquisadores (pesquisador_id),
    CONSTRAINT FOREIGN KEY(identificacao) REFERENCES Amostras_PCR (identificacao) ON DELETE CASCADE
);

-- CRIAÇÃO DA TABELA DOS EXPERIMENTOS QUE SERÃO FEITOS COM AS AMOSTRAS DE PCR COM DATA, IDENTIFICAÇÃO, TIPO E ID 
-- PARA ORGANIZAÇÃO DAS AMOSTRAS QUE FORAM ANALISADAS E PARA SABER QUAIS PRECISAM SER ANALISADAS AINDA
CREATE TABLE Experimentos (
    experimento_id INTEGER PRIMARY KEY,
    identificacao VARCHAR(100),
    data_experimento DATE NOT NULL,
    tipo_experimento VARCHAR(40),
    FOREIGN KEY (identificacao) REFERENCES Amostras_PCR(identificacao)
);

-- CRIAÇÃO DA TABELA DE RESULTADOS DOS EXPERIMENTOS COM PCR PARA QUE OS PACIENTES SEJAM DEVIDAMENTE DIAGNOSTICADOS E RECEBAM O TRATAMENTO ADEQUADO
CREATE TABLE Resultados_Experimento (
    resultado_id INT PRIMARY KEY,
    experimento_id INT,
    resultado VARCHAR(100) NOT NULL,
    data_resultado DATE NOT NULL,
    FOREIGN KEY (experimento_id) REFERENCES Experimentos(experimento_id)
);

-- INSERÇÃO DE DADOS NA TABELA PESQUISADORES 
INSERT INTO Pesquisadores (pesquisador_id, nome, email)
VALUES 
(1, 'João Barbosa', 'joao.fernandes@ufcpsa.edu.br'),
(2, 'Nicole Redmann', 'nicole.redmann@ufcspa.edu.br'),
(3, 'Helena Tubino', 'helena.garbin@ufcspa.edu.br'),
(4, 'Marina Silveira', 'marina.acosta@ufcspa.edu.br');

-- INSERÇÃO DE DADOS NA TABELA DE AMOSTRAS
INSERT INTO Amostras_PCR (identificacao, data_coleta, tipo_amostra, pesquisador_id)
VALUES 
('Amostra001', '2024-03-15', 'DNA', 1),
('Amostra002', '2024-03-20', 'RNA', 3),
('Amostra003', '2024-03-22', 'DNA', 1),
('Amostra004', '2024-04-10', 'RNA', 2),
('Amostra005', '2024-04-15', 'DNA', 4),
('Amostra006', '2024-04-22', 'DNA', 1),
('Amostra007', '2024-04-27', 'RNA', 2),
('Amostra008', '2024-05-01', 'DNA', 3),
('Amostra009', '2024-05-08', 'DNA', 1),
('Amostra010', '2024-05-13', 'RNA', 4);

-- INSERÇÃO DE DADOS NA TABELA ANALISAM
INSERT INTO Analisam (pesquisador_id, identificacao)
VALUES 
(1, 'Amostra001'),
(2, 'Amostra002'),
(1, 'Amostra003'),
(2, 'Amostra004'),
(4, 'Amostra005'),
(1, 'Amostra006'),
(2, 'Amostra007'),
(3, 'Amostra008'),
(1, 'Amostra009'),
(4, 'Amostra010');

-- INSERÇÃO DE DADOS NA TABELA DOS EXPERIMENTOS
INSERT INTO Experimentos (experimento_id, identificacao, data_experimento, tipo_experimento)
VALUES 
(1, 'Amostra001', '2024-03-16', 'RT-PCR'),
(2, 'Amostra002', '2024-03-21', 'RT-PCR'),
(3, 'Amostra003', '2024-03-23', 'RT-PCR'),
(4, 'Amostra004', '2024-04-11', 'RT-PCR'),
(5, 'Amostra005', '2024-04-16', 'RT-PCR'),
(6, 'Amostra006', '2024-04-23', 'RT-PCR'),
(7, 'Amostra007', '2024-04-28', 'RT-PCR'),
(8, 'Amostra008', '2024-05-02', 'RT-PCR'),
(9, 'Amostra009', '2024-05-09', 'RT-PCR'),
(10, 'Amostra010', '2024-05-14', 'RT-PCR');

-- INSERÇÃO DE DADOS NA TABELA DE RESULTADOS DOS EXPERIMENTOS 
INSERT INTO Resultados_Experimento (resultado_id, experimento_id, resultado, data_resultado)
VALUES 
(1, 1, 'Positivo', '2024-03-18'),
(2, 2, 'Negativo', '2024-03-23'),
(3, 3, 'Negativo', '2024-03-25'),
(4, 4, 'Positivo', '2024-04-13'),
(5, 5, 'Positivo', '2024-04-19'),
(6, 6, 'Negativo', '2024-04-26'),
(7, 7, 'Negativo', '2024-05-01'),
(8, 8, 'Positivo', '2024-05-05'),
(9, 9, 'Positivo', '2024-05-12'),
(10, 10, 'Negativo', '2024-05-17');








