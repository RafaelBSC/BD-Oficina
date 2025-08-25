use oficina;


INSERT INTO CLIENTE (NOME, CPF_CNPJ, ENDERECO) VALUES
('João Silva','12345678901','Rua A, 100'),
('Maria Souza','98765432100','Rua B, 200');

-- Veículos
INSERT INTO VEICULO (ID_CLIENTE, MARCA, MODELO, PLACA, ANO) VALUES
(1,'Fiat','Uno','ABC1234',2010),
(2,'Honda','Civic','XYZ5678',2018);

-- Equipes
INSERT INTO EQUIPE (NOME) VALUES
('Equipe A'),
('Equipe B');

-- Mecânicos
INSERT INTO MECANICO (NOME, ESPECIALIDADE, ENDERECO, ID_EQUIPE) VALUES
('Carlos','Motor','Rua C, 300',1),
('Ana','Suspensão','Rua D, 400',2);

-- OS
INSERT INTO OS (ID_VEICULO, ID_EQUIPE, DATA_EMISSAO, DATA_CONCLUSAO, STATUS, VALOR_TOTAL) VALUES
(1,1,'2025-08-01','2025-08-03','Concluída',500.00),
(2,2,'2025-08-02',NULL,'Em processamento',750.00);

-- Serviços
INSERT INTO SERVICO (DESCRICAO, VALOR_MAO_DE_OBRA) VALUES
('Troca de óleo',100.00),
('Alinhamento',50.00);

-- Tipo de serviço
INSERT INTO TIPO_DE_SERVICO (OS_idOS, SERVICO_idSERVICO) VALUES
(1,1),
(1,2),
(2,2);

-- Peças
INSERT INTO PECA (NOME_PECA, VALOR) VALUES
('Filtro de óleo',50.00),
('Pneu',200.00);

-- OS_PECA
INSERT INTO OS_PECA (OS_idOS, PECA_idPECA, QUANTIDADE) VALUES
(1,1,1),
(2,2,4);

-- Pedidos de peças
INSERT INTO PEDIDOS_DE_PECAS (OS_idOS, OS_PECA_idOS_PECA) VALUES
(1,1),
(2,2);

-- Disponibilidade de peças
INSERT INTO DISPONIBILIDADE_DE_PEÇAS (OS_PECA_idOS_PECA, PECA_idPECA) VALUES
(1,1),
(2,2);


-- Recuperação simples com SELECT
-- Liste todos os clientes cadastrados com seus veículos
SELECT c.NOME AS Cliente, v.MODELO AS Veiculo, v.PLACA
FROM CLIENTE c
JOIN VEICULO v ON c.idCLIENTE = v.ID_CLIENTE;

-- Filtros com WHERE
-- Quais ordens de serviço já foram concluídas?
SELECT idOS, STATUS, DATA_CONCLUSAO, VALOR_TOTAL
FROM OS
WHERE STATUS = 'Concluída';


-- Expressões e Ordenação com ORDER BY
-- Liste os serviços realizados mostrando também o custo total (mão de obra × quantidade), ordenados do mais caro para o mais barato
SELECT 
    s.DESCRICAO,
    s.VALOR_MAO_DE_OBRA,
    osvc.QUANTIDADE,
    (s.VALOR_MAO_DE_OBRA * osvc.QUANTIDADE) AS Custo_Total
FROM OS_SERVICO AS osvc
JOIN SERVICO AS s 
  ON osvc.IDSERVICO = s.idSERVICO
ORDER BY Custo_Total DESC;

-- Agrupamento, HAVING e Junções
-- Quais ordens de serviço utilizaram mais de 2 peças?
SELECT o.idOS,
       SUM(op.QUANTIDADE) AS Total_Pecas
FROM OS o
JOIN OS_PECA op ON o.idOS = op.OS_idOS
GROUP BY o.idOS
HAVING SUM(op.QUANTIDADE) > 2;



