SELECT 
    h.nome_completo,
    h.cpf,
    q.numero AS numero_quarto,
    r.data_entrada_prevista,
    r.data_saida_prevista,
    r.status_reserva
FROM reserva r
INNER JOIN hospede h ON r.id_hospede = h.id_hospede
INNER JOIN quarto q ON r.id_quarto = q.id_quarto;

SELECT 
    f.nome_funcionario AS recepcionista,
    e.data_checkin,
    q.numero AS quarto,
    h.nome_completo AS hospede
FROM estadia e
INNER JOIN funcionario f ON e.id_funcionario_checkin = f.id_funcionario
INNER JOIN quarto q ON e.id_quarto = q.id_quarto
INNER JOIN reserva r ON e.id_reserva = r.id_reserva
INNER JOIN hospede h ON r.id_hospede = h.id_hospede;

SELECT 
    q.numero AS quarto,
    i.nome_item,
    c.quantidade,
    i.preco_unitario,
    (c.quantidade * i.preco_unitario) AS total_item,
    c.data_consumo
FROM consumo c
INNER JOIN item_consumivel i ON c.id_item = i.id_item
INNER JOIN estadia e ON c.id_estadia = e.id_estadia
INNER JOIN quarto q ON e.id_quarto = q.id_quarto
ORDER BY q.numero, c.data_consumo;

SELECT 
    e.id_estadia,
    h.nome_completo,
    SUM(c.quantidade * i.preco_unitario) AS total_consumo
FROM consumo c
INNER JOIN item_consumivel i ON c.id_item = i.id_item
INNER JOIN estadia e ON c.id_estadia = e.id_estadia
INNER JOIN reserva r ON e.id_reserva = r.id_reserva
INNER JOIN hospede h ON r.id_hospede = h.id_hospede
GROUP BY e.id_estadia, h.nome_completo;

SELECT 
    p.id_pagamento,
    h.nome_completo,
    p.valor,
    p.forma_pagamento,
    p.data_pagamento
FROM pagamento p
INNER JOIN estadia e ON p.id_estadia = e.id_estadia
INNER JOIN reserva r ON e.id_reserva = r.id_reserva
INNER JOIN hospede h ON r.id_hospede = h.id_hospede;

SELECT 
    f.nome_funcionario,
    q.numero AS quarto,
    l.data_hora_inicio,
    l.observacoes
FROM limpeza l
INNER JOIN funcionario f ON l.id_funcionario = f.id_funcionario
INNER JOIN quarto q ON l.id_quarto = q.id_quarto
ORDER BY l.data_hora_inicio DESC;

SELECT 
    q.numero,
    q.andar,
    m.descricao_problema,
    m.custo_reparo,
    m.data_conclusao
FROM quarto q
LEFT JOIN manutencao m ON q.id_quarto = m.id_quarto
ORDER BY q.numero;

SELECT 
    h.nome_completo,
    r.data_entrada_prevista,
    e.data_checkin AS entrada_real,
    q_reserva.numero AS quarto_reservado,
    q_real.numero AS quarto_ocupado
FROM estadia e
INNER JOIN reserva r ON e.id_reserva = r.id_reserva
INNER JOIN hospede h ON r.id_hospede = h.id_hospede
INNER JOIN quarto q_reserva ON r.id_quarto = q_reserva.id_quarto
INNER JOIN quarto q_real ON e.id_quarto = q_real.id_quarto;

SELECT 
    i.nome_item,
    i.tipo,
    SUM(c.quantidade) AS total_vendido
FROM consumo c
INNER JOIN item_consumivel i ON c.id_item = i.id_item
GROUP BY i.nome_item, i.tipo
ORDER BY total_vendido DESC;

SELECT 
    q.capacidade_pessoas AS tipo_quarto,
    COUNT(e.id_estadia) AS total_estadias,
    SUM(e.valor_final) AS receita_gerada
FROM estadia e
INNER JOIN quarto q ON e.id_quarto = q.id_quarto
WHERE e.valor_final IS NOT NULL
GROUP BY q.capacidade_pessoas;

SELECT 
    q.numero,
    q.andar,
    h.nome_completo,
    h.telefone
FROM quarto q
INNER JOIN estadia e ON q.id_quarto = e.id_quarto
INNER JOIN reserva r ON e.id_reserva = r.id_reserva
INNER JOIN hospede h ON r.id_hospede = h.id_hospede
WHERE q.status_atual = 'Ocupado' 
AND e.data_checkout IS NULL; 

SELECT 
    h.nome_completo,
    q.numero AS quarto,
    e.data_checkin,
    e.data_checkout,
    p.valor AS total_pago,
    f.nome_funcionario AS atendente_checkin
FROM hospede h
INNER JOIN reserva r ON h.id_hospede = r.id_hospede
INNER JOIN estadia e ON r.id_reserva = e.id_reserva
INNER JOIN quarto q ON e.id_quarto = q.id_quarto
INNER JOIN funcionario f ON e.id_funcionario_checkin = f.id_funcionario
LEFT JOIN pagamento p ON e.id_estadia = p.id_estadia;