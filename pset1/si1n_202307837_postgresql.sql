--cria um usuario com senha criptografada
CREATE USER ana_julia WITH ENCRYPTED PASSWORD '1234';

--altera o usuario para que ele consiga criar banco de dados e usuarios
ALTER ROLE ana_julia CREATEDB CREATEROLE;

--mudar para usuario ana_julia
SET ROLE ana_julia;

--criar o banco de dados
CREATE DATABASE uvv;

--entrar no bando de dados com ana_julia
\c uvv
SET ROLE ana_julia;

--criar o scherma lojas
CREATE SCHEMA lojas;

--tornar o schema lojas como principal
SET SEARCH_PATH TO lojas, "$user", public;

--torna o schema lojas permanente
ALTER DATABASE uvv SET SEARCH_PATH TO lojas, '$user', public;

--cria a tabela produtos
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) DEFAULT 38 NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atuailzacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

--cometarios da tabela produtos
COMMENT ON TABLE lojas.produtos IS 'tabela com dados referentes aos produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'chave primaria da tabela produtos, armazena o id dos produtos';
COMMENT ON COLUMN lojas.produtos.nome IS 'referente ao nome dos produtos';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'refrente ao preço da unidade do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'referente aos detalhes dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem IS 'referente as imagens dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'referente ao mime type do produto';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'referente aos arquivos do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'referente ao charset dos produtos';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atuailzacao IS 'referente a ultima atualização da imagem dos produtos';

--cria a tabela lojas
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);
--comenta a tabela lojas
COMMENT ON TABLE lojas.lojas IS 'tabela referente as lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'chave primaria da tabela lojas, armazena os id das lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'referente ao nome das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'referente ao endereço web das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'referente ao endereço fisico das lojas';
COMMENT ON COLUMN lojas.lojas.latitude IS 'referente a latitude das lojas';
COMMENT ON COLUMN lojas.lojas.longitude IS 'referente a longitude das lojas';
COMMENT ON COLUMN lojas.lojas.logo IS 'referente as logos das lojas';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'referente ao mime type da logo das lojas';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'referente ao arquivo da logo';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'referente ao charset da logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'referente a ultima atualização da logo';

--cria a tabela estoques
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) DEFAULT 38 NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);

--comenta a tabela estoques
COMMENT ON TABLE lojas.estoques IS 'tabela referente aos dados sobre o estoque';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'chave primária da tabela estoque, armazena o id do estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'chave primaria da tabela lojas, armazena os id das lojas';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'chave primaria da tabela produtos, armazena o id dos produtos';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'referente a quantidade de produtos no estoque';

--cria a tabela clientes
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id_pk PRIMARY KEY (cliente_id)
);

--comenta a tabela clientes
COMMENT ON TABLE lojas.clientes IS 'tabela responsável por armazenar dados dos clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'chave primaria que contem o id dos clientes';
COMMENT ON COLUMN lojas.clientes.email IS 'referente ao email dos clientes';
COMMENT ON COLUMN lojas.clientes.nome IS 'referente ao nome dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'referente ao primeiro telefone registrado do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'referente ao segundo telefone registrado pelo cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'referente ao terceiro telefone registrado pelo cliente';

--cria a tabela envios
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);

--comenta a tabela envios
COMMENT ON TABLE lojas.envios IS 'tabela referente aos envios dos produtos';
COMMENT ON COLUMN lojas.envios.envio_id IS 'referente ao id de envio dos produtos';
COMMENT ON COLUMN lojas.envios.loja_id IS 'chave primaria da tabela lojas, armazena os id das lojas';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'chave primaria que contem o id dos clientes';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'referente ao endereçode entrega dos produtos';
COMMENT ON COLUMN lojas.envios.status IS 'referente aos status de envio dos produtos';

--cria a tabela pedidos
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);

--comenta a tabela pedidos
COMMENT ON TABLE lojas.pedidos IS 'tabela referente aos informações sobre os pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'chave primaria dos pedidos, suas informações são referentes ao id dos pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'referente a data e hora dos pedidos';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'chave primaria que contem o id dos clientes';
COMMENT ON COLUMN lojas.pedidos.status IS 'referente ao status dos pedidos';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'chave primaria da tabela lojas, armazena os id das lojas';

--cria a tabela peido_itens
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) DEFAULT 38 NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id_produto_id_pfk PRIMARY KEY (pedido_id, produto_id)
);
--comenta a tabela pedido_iten
COMMENT ON TABLE lojas.pedidos_itens IS 'referente aos itens dos pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'chave primaria dos pedidos, suas informações são referentes ao id dos pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'chave primaria da tabela produtos, armazena o id dos produtos';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'referente ao numero de linha dos itens pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'referente ao preço unitario dos itens pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'referente a quantidade de itens pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'referente ao id de envio dos produtos';


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedido_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedido_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedido_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
