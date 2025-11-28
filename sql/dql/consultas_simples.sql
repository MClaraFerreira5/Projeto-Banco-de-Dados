
-- 1. Listar todos os dados de todos os hóspedes cadastrados.

SELECT * FROM hospede;

-- 2. Listar apenas o nome e o telefone dos funcionários que são 'Recepcionista'.
SELECT nome_funcionario, cpf_funcionario
FROM funcionario
WHERE cargo = 'Recepcionista';

-- 3. Encontrar todos os quartos que estão atualmente com status 'Livre'.
SELECT numero, andar, preco_diaria, capacidade_pessoas
FROM quarto
WHERE status_atual = 'Livre';

-- 4. Listar os itens consumíveis (produtos/serviços) ordenados do mais caro para o mais barato.

SELECT nome_item, tipo, preco_unitario
FROM item_consumivel
ORDER BY preco_unitario DESC;

-- 5. Mostrar as próximas 10 reservas previstas para entrar a partir de hoje.
SELECT id_reserva, data_entrada_prevista, data_saida_prevista, status_reserva
FROM reserva
WHERE data_entrada_prevista >= CURRENT_DATE
ORDER BY data_entrada_prevista ASC
LIMIT 10;

-- 6. Contar quantos quartos existem em cada andar.

SELECT andar, COUNT(*) AS total_quartos
FROM quarto
GROUP BY andar
ORDER BY andar;

-- 7. Calcular a média de preço das diárias de todos os quartos do hotel.
SELECT AVG(preco_diaria) AS media_preco_diaria
FROM quarto;

-- 8. Somar o valor total de todos os pagamentos recebidos via 'PIX'.
SELECT SUM(valor) AS total_recebido_pix
FROM pagamento
WHERE forma_pagamento = 'PIX';

-- 9. Listar as manutenções que ainda não foram concluídas (data_conclusao é nula).
SELECT id_manutencao, descricao_problema, data_abertura
FROM manutencao
WHERE data_conclusao IS NULL;

-- 10. Listar os nomes dos hóspedes que possuem e-mail do 'gmail.com'.
SELECT nome_completo, email
FROM hospede
WHERE email LIKE '%@gmail.com';

-- 11. Mostrar quais são os diferentes tipos de cargos existentes entre os funcionários.
SELECT DISTINCT cargo
FROM funcionario;

-- 12. Encontrar o quarto com a diária mais cara do hotel.

SELECT numero, preco_diaria
FROM quarto
ORDER BY preco_diaria DESC
LIMIT 1;
