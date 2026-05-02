CREATE DATABASE IF NOT EXISTS Hotel;
USE Hotel;

CREATE TABLE Tempo (
    idTempo INT PRIMARY KEY,
    ano CHAR(4),
    mes CHAR(2),
    dia VARCHAR(2)
);

CREATE TABLE Hospede (
    idHospede INT PRIMARY KEY,
    nome VARCHAR(40)
);

CREATE TABLE Agencia (
    idAgencia INT PRIMARY KEY,
    nome VARCHAR(30)
);

CREATE TABLE Apto (
    idApartamento INT PRIMARY KEY,
    numero INT,
    andar INT,
    tipo VARCHAR(10)
);

CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    Descricao VARCHAR(30)
);

CREATE TABLE Servico (
    idServico INT PRIMARY KEY,
    Descricao VARCHAR(30)
);


CREATE TABLE Hospedagem (
    Hospede_idHospede INT,
    Meio_Transporte INT,
    Agencia_idAgencia INT,
    Apartamento_idApartamento INT,
    Motivo_Viagem INT,
    Tempo_idTempo INT,
    Valor_Faturado DOUBLE,
    PRIMARY KEY (Hospede_idHospede, Agencia_idAgencia, Apartamento_idApartamento, Tempo_idTempo),
    FOREIGN KEY (Hospede_idHospede) REFERENCES Hospede(idHospede),
    FOREIGN KEY (Agencia_idAgencia) REFERENCES Agencia(idAgencia),
    FOREIGN KEY (Apartamento_idApartamento) REFERENCES Apto(idApartamento),
    FOREIGN KEY (Tempo_idTempo) REFERENCES Tempo(idTempo)
);

CREATE TABLE Consumo (
    Tempo_idTempo INT,
    Hospede_idHospede INT,
    Apto_idApartamento INT,
    Produto_idProduto INT,
    Servico_idServico INT,
    quantidade INT,
    Valor_Consumo DOUBLE,
    PRIMARY KEY (Tempo_idTempo, Hospede_idHospede, Apto_idApartamento, Produto_idProduto, Servico_idServico),
    FOREIGN KEY (Tempo_idTempo) REFERENCES Tempo(idTempo),
    FOREIGN KEY (Hospede_idHospede) REFERENCES Hospede(idHospede),
    FOREIGN KEY (Apto_idApartamento) REFERENCES Apto(idApartamento),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);

CREATE INDEX idx_hospedagem_meio_transporte ON Hospedagem(Meio_Transporte);
CREATE INDEX idx_hospedagem_motivo_viagem ON Hospedagem(Motivo_Viagem);

CREATE INDEX idx_tempo_ano_mes ON Tempo(ano, mes);
CREATE INDEX idx_apto_tipo ON Apto(tipo);

SELECT h.nome, a.nome as Agencia, ap.numero, t.mes, f.Valor_Faturado
FROM Hospedagem f
JOIN Hospede h ON f.Hospede_idHospede = h.idHospede
JOIN Agencia a ON f.Agencia_idAgencia = a.idAgencia
JOIN Apto ap ON f.Apartamento_idApartamento = ap.idApartamento
JOIN Tempo t ON f.Tempo_idTempo = t.idTempo;

SELECT h.nome, p.Descricao as Produto, s.Descricao as Servico, f.quantidade, f.Valor_Consumo
FROM Consumo f
JOIN Hospede h ON f.Hospede_idHospede = h.idHospede
JOIN Produto p ON f.Produto_idProduto = p.idProduto
JOIN Servico s ON f.Servico_idServico = s.idServico;
