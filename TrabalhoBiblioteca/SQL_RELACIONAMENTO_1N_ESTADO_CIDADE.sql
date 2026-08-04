-- =====================================================
-- SCRIPT PARA IMPLEMENTAR O RELACIONAMENTO 1:N
-- ESTADO (1) -> CIDADE (N)
-- =====================================================

-- Criação da tabela cidade
CREATE TABLE cidade (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    codigo_estado INTEGER NOT NULL,
    CONSTRAINT fk_cidade_estado
        FOREIGN KEY (codigo_estado)
        REFERENCES estado(codigo)
);

-- Estados de exemplo
INSERT INTO estado (nome, sigla) VALUES ('São Paulo', 'SP');
INSERT INTO estado (nome, sigla) VALUES ('Minas Gerais', 'MG');
INSERT INTO estado (nome, sigla) VALUES ('Paraná', 'PR');

INSERT INTO cidade (nome, codigo_estado) VALUES ('Jales', 7);
INSERT INTO cidade (nome, codigo_estado) VALUES ('Urânia', 7);
INSERT INTO cidade (nome, codigo_estado) VALUES ('Belo Horizonte', 8);
INSERT INTO cidade (nome, codigo_estado) VALUES ('Curitiba', 9);
