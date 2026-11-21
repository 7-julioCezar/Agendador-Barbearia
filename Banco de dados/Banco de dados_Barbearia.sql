CREATE DATABASE BD_barbearia;

use BD_barbearia;

-- ==========================================
-- USUÁRIOS DO SISTEMA
-- ==========================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,

    tipo ENUM('CLIENTE','BARBEIRO') NOT NULL,

    eh_admin BOOLEAN DEFAULT FALSE,

    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- ==========================================
-- CONFIGURAÇÃO DA SENHA DE ADMIN
-- ==========================================

CREATE TABLE configuracao_admin (
    id_config INT AUTO_INCREMENT PRIMARY KEY,

    senha_verificacao VARCHAR(255) NOT NULL
);



-- ==========================================
-- DADOS DO CLIENTE
-- ==========================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    telefone VARCHAR(20),

    FOREIGN KEY(id_usuario)
        REFERENCES usuarios(id_usuario)
);



-- ==========================================
-- DADOS ESPECÍFICOS DO BARBEIRO
-- ==========================================

CREATE TABLE barbeiros (
    id_barbeiro INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    especialidade VARCHAR(100),

    FOREIGN KEY(id_usuario)
        REFERENCES usuarios(id_usuario)
);



-- ==========================================
-- SERVIÇOS DA BARBEARIA
-- ==========================================

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,

    nome VARCHAR(100) NOT NULL,

    descricao TEXT,

    preco DECIMAL(10,2) NOT NULL,

    duracao INT NOT NULL,

    ativo BOOLEAN DEFAULT TRUE
);



-- ==========================================
-- AGENDAMENTOS
-- ==========================================

CREATE TABLE agendamentos (

    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,

    id_barbeiro INT NOT NULL,

    id_servico INT NOT NULL,


    data_agendamento DATE NOT NULL,

    horario TIME NOT NULL,


    status ENUM(
        'PENDENTE',
        'CONFIRMADO',
        'CANCELADO',
        'CONCLUIDO'
    ) DEFAULT 'PENDENTE',


    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,


    FOREIGN KEY(id_cliente)
        REFERENCES clientes(id_cliente),


    FOREIGN KEY(id_barbeiro)
        REFERENCES barbeiros(id_barbeiro),


    FOREIGN KEY(id_servico)
        REFERENCES servicos(id_servico)

);



-- ==========================================
-- HISTÓRICO DE ATENDIMENTOS
-- ==========================================

CREATE TABLE atendimentos (

    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,

    id_agendamento INT NOT NULL,

    observacao TEXT,

    valor_pago DECIMAL(10,2),


    data_atendimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,


    FOREIGN KEY(id_agendamento)
        REFERENCES agendamentos(id_agendamento)

);



-- ==========================================
-- DESCONTOS PERSONALIZADOS
-- ==========================================

CREATE TABLE descontos (

    id_desconto INT AUTO_INCREMENT PRIMARY KEY,

    id_cliente INT NOT NULL,

    percentual DECIMAL(5,2) NOT NULL,

    motivo VARCHAR(255),

    validade DATE,


    FOREIGN KEY(id_cliente)
        REFERENCES clientes(id_cliente)

);