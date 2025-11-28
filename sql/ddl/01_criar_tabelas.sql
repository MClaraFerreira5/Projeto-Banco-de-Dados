-- 1. Tabela: Hóspede
CREATE TABLE IF NOT EXISTS hospede (
    id_hospede INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_completo VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(255)
);

-- 2. Tabela: Quarto
CREATE TABLE IF NOT EXISTS quarto (
    id_quarto INTEGER PRIMARY KEY AUTOINCREMENT,
    numero INT NOT NULL UNIQUE,
    andar INT NOT NULL,
    preco_diaria DECIMAL(10, 2) NOT NULL,
    capacidade_pessoas INT NOT NULL,
    status_atual VARCHAR(50) DEFAULT 'Livre'
);

-- 3. Tabela: Funcionário
CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_funcionario VARCHAR(255) NOT NULL,
    cpf_funcionario CHAR(11) NOT NULL UNIQUE,
    cargo VARCHAR(100) NOT NULL
);

-- 4. Tabela: ItemConsumivel
CREATE TABLE IF NOT EXISTS item_consumivel (
    id_item INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_item VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL
);

-- 5. Tabela: Reserva
CREATE TABLE IF NOT EXISTS reserva (
    id_reserva INTEGER PRIMARY KEY AUTOINCREMENT,
    data_reserva_feita DATE NOT NULL DEFAULT CURRENT_DATE,
    data_entrada_prevista DATE NOT NULL,
    data_saida_prevista DATE NOT NULL,
    status_reserva VARCHAR(50) NOT NULL,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    FOREIGN KEY (id_hospede) REFERENCES hospede(id_hospede),
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
);

-- 6. Tabela: Estadia
CREATE TABLE IF NOT EXISTS estadia (
    id_estadia INTEGER PRIMARY KEY AUTOINCREMENT,
    data_checkin TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_checkout TIMESTAMP,
    valor_final DECIMAL(10, 2),
    id_reserva INT NOT NULL UNIQUE,
    id_funcionario_checkin INT NOT NULL,
    id_quarto INT NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    FOREIGN KEY (id_funcionario_checkin) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
);

-- 7. Tabela: Pagamento
CREATE TABLE IF NOT EXISTS pagamento (
    id_pagamento INTEGER PRIMARY KEY AUTOINCREMENT,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento VARCHAR(50) NOT NULL,
    id_estadia INT NOT NULL UNIQUE,
    FOREIGN KEY (id_estadia) REFERENCES estadia(id_estadia)
);

-- 8. Tabela: Consumo
CREATE TABLE IF NOT EXISTS consumo (
    id_consumo INTEGER PRIMARY KEY AUTOINCREMENT,
    data_consumo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantidade INT NOT NULL DEFAULT 1,
    id_estadia INT NOT NULL,
    id_item INT NOT NULL,
    FOREIGN KEY (id_estadia) REFERENCES estadia(id_estadia),
    FOREIGN KEY (id_item) REFERENCES item_consumivel(id_item)
);

-- 9. Tabela: Limpeza
CREATE TABLE IF NOT EXISTS limpeza (
    id_limpeza INTEGER PRIMARY KEY AUTOINCREMENT,
    data_hora_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_hora_fim TIMESTAMP,
    observacoes TEXT,
    id_funcionario INT NOT NULL,
    id_quarto INT NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
);

-- 10. Tabela: Manutenção
CREATE TABLE IF NOT EXISTS manutencao (
    id_manutencao INTEGER PRIMARY KEY AUTOINCREMENT,
    data_abertura TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_conclusao TIMESTAMP,
    descricao_problema TEXT NOT NULL,
    custo_reparo DECIMAL(10, 2),
    id_funcionario INT NOT NULL,
    id_quarto INT NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
);