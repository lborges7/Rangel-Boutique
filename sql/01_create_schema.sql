
-- CLIENTE
CREATE TABLE cliente (
  idcliente       BIGSERIAL PRIMARY KEY,
  nome            VARCHAR(150) NOT NULL,
  email           VARCHAR(150) NOT NULL UNIQUE,
  cpf             CHAR(11) NOT NULL UNIQUE,
  senha           VARCHAR(255) NOT NULL, -- armazenar hash
  telefone        VARCHAR(20),
  datacadastro    TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- ENDERECO
CREATE TABLE endereco (
  idendereco      BIGSERIAL PRIMARY KEY,
  idcliente       BIGINT NOT NULL REFERENCES cliente(idcliente) ON DELETE RESTRICT,
  logradouro      VARCHAR(150) NOT NULL,
  numero          VARCHAR(20) NOT NULL,
  complemento     VARCHAR(80),
  bairro          VARCHAR(60) NOT NULL,
  cidade          VARCHAR(60) NOT NULL,
  estado          CHAR(2) NOT NULL,
  cep             CHAR(8) NOT NULL,
  tipo            VARCHAR(30) DEFAULT 'entrega' -- entrega / cobranca / outros
);

-- CATEGORIA
CREATE TABLE categoria (
  idcategoria     BIGSERIAL PRIMARY KEY,
  nomecategoria   VARCHAR(100) NOT NULL UNIQUE,
  descricaocategoria VARCHAR(255)
);

-- PRODUTO
CREATE TABLE produto (
  idproduto       BIGSERIAL PRIMARY KEY,
  idcategoria     BIGINT NOT NULL REFERENCES categoria(idcategoria) ON DELETE RESTRICT,
  nome            VARCHAR(150) NOT NULL,
  descricao       TEXT,
  precobase       NUMERIC(10,2) NOT NULL,
  ativo           BOOLEAN DEFAULT TRUE
);

-- VARIACAO (SKU / estoque por combinação)
CREATE TABLE variacao (
  idvariacao      BIGSERIAL PRIMARY KEY,
  idproduto       BIGINT NOT NULL REFERENCES produto(idproduto) ON DELETE RESTRICT,
  sku             VARCHAR(60) NOT NULL UNIQUE,
  cor             VARCHAR(50) NOT NULL,
  tamanho         VARCHAR(20) NOT NULL,
  quantidadeestoque INT NOT NULL DEFAULT 0,
  ativo           BOOLEAN DEFAULT TRUE
);

-- PEDIDO
CREATE TABLE pedido (
  idpedido        BIGSERIAL PRIMARY KEY,
  idcliente       BIGINT NOT NULL REFERENCES cliente(idcliente) ON DELETE RESTRICT,
  idenderecoentrega BIGINT REFERENCES endereco(idendereco), -- snapshot also below
  datapedido      TIMESTAMP WITH TIME ZONE DEFAULT now(),
  statuspedido    VARCHAR(30) NOT NULL DEFAULT 'em_processamento', -- ex: em_processamento, enviado, entregue, cancelado, devolucao
  valortotal      NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  codigorastreamento VARCHAR(100),

  -- snapshot de endereço no momento do pedido (integridade histórica)
  logradouroentrega VARCHAR(150),
  numeroentrega     VARCHAR(20),
  cidadeentrega     VARCHAR(60),
  estadoentrega     CHAR(2),
  cepentrega        CHAR(8)
);

-- ITEMPEDIDO (linhas do pedido)
CREATE TABLE itempedido (
  iditempedido    BIGSERIAL PRIMARY KEY,
  idpedido        BIGINT NOT NULL REFERENCES pedido(idpedido) ON DELETE RESTRICT,
  idvariacao      BIGINT NOT NULL REFERENCES variacao(idvariacao) ON DELETE RESTRICT,
  quantidade      INT NOT NULL CHECK (quantidade > 0),
  precounitario   NUMERIC(10,2) NOT NULL, -- snapshot do preço
  subtotal        NUMERIC(10,2) NOT NULL
);

-- PAGAMENTO
CREATE TABLE pagamento (
  idpagamento     BIGSERIAL PRIMARY KEY,
  idpedido        BIGINT UNIQUE NOT NULL REFERENCES pedido(idpedido) ON DELETE RESTRICT,
  formapagamento  VARCHAR(40) NOT NULL, -- ex: pix, cartao, boleto
  statuspagamento VARCHAR(30) NOT NULL DEFAULT 'pendente', -- aprovado, recusado, estornado
  valorpago       NUMERIC(10,2) NOT NULL,
  datapagamento   TIMESTAMP WITH TIME ZONE
);

COMMIT;


CREATE INDEX idx_variacao_produto ON variacao(idproduto);
CREATE INDEX idx_pedido_cliente ON pedido(idcliente);
CREATE INDEX idx_itempedido_pedido ON itempedido(idpedido);
CREATE INDEX idx_itempedido_variacao ON itempedido(idvariacao);

