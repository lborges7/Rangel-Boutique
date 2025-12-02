-- Populando clientes
INSERT INTO cliente (nome, email, cpf, senha, telefone, datacadastro) VALUES
('Ana Souza',    'ana.souza@example.com',   '12345678901', 'hash_a1', '11988887777', now() - interval '90 day'),
('Beatriz Lima', 'beatriz.lima@example.com','23456789012', 'hash_b2', '11977776666', now() - interval '120 day'),
('Carla Dias',   'carla.dias@example.com',  '34567890123', 'hash_c3', '11966665555', now() - interval '30 day'),
('Daniela R.',   'daniela.r@example.com',   '45678901234', 'hash_d4', '11955554444', now() - interval '60 day'),
('Eduarda M',    'eduarda.m@example.com',   '56789012345', 'hash_e5', '11944443333', now() - interval '10 day');

-- Endereços
INSERT INTO endereco (idcliente, logradouro, numero, complemento, bairro, cidade, estado, cep, tipo) VALUES
(1,'Rua das Flores','123','Apto 12','Jardim','Sao Paulo','SP','01001000','entrega'),
(1,'Av. Paulista','1500','Sala 400','Bela Vista','Sao Paulo','SP','01310000','cobranca'),
(2,'Rua do Sol','45',NULL,'Centro','Sao Paulo','SP','02020000','entrega'),
(3,'Rua Verde','78','Casa','Vila Nova','Sao Paulo','SP','03030000','entrega'),
(4,'Rua Azul','10','Bloco B','Pinheiros','Sao Paulo','SP','04040000','entrega'),
(5,'Rua Amarela','7','Loja','Moema','Sao Paulo','SP','05050000','entrega');

-- Categorias
INSERT INTO categoria (nomecategoria, descricaocategoria) VALUES
('Vestidos','Vestidos femininos: casuais e festa'),
('Blusas','Blusas e camisetas'),
('Acessorios','Colares, brincos e cintos'),
('Saias','Saias de vários comprimentos'),
('Calcas','Calças e leggings');

-- Produtos
INSERT INTO produto (idcategoria, nome, descricao, precobase) VALUES
(1,'Vestido Floral Midi','Vestido midi estampado floral',129.90),
(1,'Vestido Preto Basico','Vestido preto elegante',149.90),
(2,'Blusa Tricot','Blusa de tricot macia',89.90),
(2,'Camiseta Algodao','Camiseta básica algodão',39.90),
(3,'Brinco Dourado','Brinco folheado dourado',49.90),
(4,'Saia Lapis','Saia lápis elegante',119.90),
(5,'Calca Jeans Skinny','Calça jeans skinny',179.90),
(3,'Cinto Fino','Cinto fino couro sintético',59.90);

-- Variações (SKU)
INSERT INTO variacao (idproduto, sku, cor, tamanho, quantidadeestoque) VALUES
(1,'VFL-001-P-ROSA','Rosa','P',5),
(1,'VFL-001-M-ROSA','Rosa','M',8),
(1,'VFL-001-G-ROSA','Rosa','G',2),
(1,'VFL-002-P-PT','Preto','P',10), -- this actually belongs to product 1 alt? Keep examples simple
(2,'VPT-001-M-PT','Preto','M',4),
(3,'BLT-001-U-AZ','Azul','U',12),
(4,'CMS-001-P-BR','Branco','P',20),
(5,'BRN-001-U-OU','Dourado','U',15),
(6,'SAI-001-M-PT','Preto','M',6),
(7,'CAL-001-38-AZ','Azul','38',7),
(8,'CIN-001-PTO','Preto','U',18);

-- Pedidos (vamos criar 6 pedidos)
INSERT INTO pedido (idcliente, idenderecoentrega, datapedido, statuspedido, valortotal,
                   logradouroentrega, numeroentrega, cidadeentrega, estadoentrega, cepentrega)
VALUES
(1, 1, now() - interval '20 day', 'entregue', 259.80, 'Rua das Flores','123','Sao Paulo','SP','01001000'),
(2, 3, now() - interval '10 day', 'enviado', 149.90, 'Rua do Sol','45','Sao Paulo','SP','02020000'),
(1, 1, now() - interval '5 day', 'em_processamento', 89.90, 'Rua das Flores','123','Sao Paulo','SP','01001000'),
(3, 4, now() - interval '3 day', 'em_processamento', 179.90, 'Rua Verde','78','Sao Paulo','SP','03030000'),
(4, 5, now() - interval '2 day', 'cancelado', 59.90, 'Rua Azul','10','Sao Paulo','SP','04040000'),
(5, 6, now() - interval '1 day', 'enviado', 119.90, 'Rua Amarela','7','Sao Paulo','SP','05050000');

-- Itens (link pedido <-> variacao)
-- Pedido 1 (idpedido should be 1)
INSERT INTO itempedido (idpedido, idvariacao, quantidade, precounitario, subtotal) VALUES
(1, 1, 1, 129.90, 129.90),
(1, 5, 1, 129.90, 129.90); -- sample mixing

-- Pedido 2
INSERT INTO itempedido (idpedido, idvariacao, quantidade, precounitario, subtotal) VALUES
(2, 5, 1, 149.90, 149.90);

-- Pedido 3
INSERT INTO itempedido (idpedido, idvariacao, quantidade, precounitario, subtotal) VALUES
(3, 6, 1, 89.90, 89.90);

-- Pedido 4
INSERT INTO itempedido (idpedido, idvariacao, quantidade, precounitario, subtotal) VALUES
(4, 7, 1, 179.90, 179.90);

-- Pedido 5 (cancelado)
INSERT INTO itempedido (idpedido, idvariacao, quantidade, precounitario, subtotal) VALUES
(5, 8, 1, 59.90, 59.90);

-- Pedido 6
INSERT INTO itempedido (idpedido, idvariacao, quantidade, precounitario, subtotal) VALUES
(6, 9, 1, 119.90, 119.90);

-- Pagamentos (1 por pedido)
INSERT INTO pagamento (idpedido, formapagamento, statuspagamento, valorpago, datapagamento) VALUES
(1, 'cartao', 'pago', 259.80, now() - interval '20 day'),
(2, 'pix', 'pago', 149.90, now() - interval '10 day'),
(3, 'boleto', 'pendente', 89.90, NULL),
(4, 'cartao', 'pago', 179.90, now() - interval '3 day'),
(5, 'pix', 'estornado', 59.90, now() - interval '1 day'),
(6, 'pix', 'pago', 119.90, now() - interval '1 day');

-- Update pedidos valortotal (in case)
UPDATE pedido p SET valortotal = sub.total
FROM (
  SELECT idpedido, SUM(subtotal) as total FROM itempedido GROUP BY idpedido
) sub
WHERE p.idpedido = sub.idpedido;

-- Example stock adjustments (deduct for orders that are paid)
UPDATE variacao v
SET quantidadeestoque = v.quantidadeestoque - ip.quant
FROM (
  SELECT idvariacao as varid, SUM(quantidade) as quant
  FROM itempedido
  JOIN pedido p ON itempedido.idpedido = p.idpedido
  WHERE p.statuspedido NOT IN ('cancelado')
  GROUP BY idvariacao
) ip
WHERE v.idvariacao = ip.varid;

-- End of seed
