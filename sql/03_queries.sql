-- 03_queries.sql

-- 1) Listar pedidos com cliente, status e total (JOIN)
SELECT p.idpedido, p.datapedido, c.nome AS cliente, p.statuspedido, p.valortotal
FROM pedido p
JOIN cliente c ON p.idcliente = c.idcliente
ORDER BY p.datapedido DESC
LIMIT 50;

-- 2) Itens de um pedido e detalhes do produto/variação
SELECT p.idpedido, c.nome AS cliente, pr.nome AS produto, v.sku, v.cor, v.tamanho,
       ip.quantidade, ip.precounitario, ip.subtotal
FROM itempedido ip
JOIN pedido p ON ip.idpedido = p.idpedido
JOIN variacao v ON ip.idvariacao = v.idvariacao
JOIN produto pr ON v.idproduto = pr.idproduto
JOIN cliente c ON p.idcliente = c.idcliente
WHERE p.idpedido = 1; -- trocar ID conforme teste

-- 3) Top 5 produtos (variações) mais vendidos por quantidade
SELECT v.sku, pr.nome AS produto, SUM(ip.quantidade) AS total_vendido
FROM itempedido ip
JOIN variacao v ON ip.idvariacao = v.idvariacao
JOIN produto pr ON v.idproduto = pr.idproduto
GROUP BY v.sku, pr.nome
ORDER BY total_vendido DESC
LIMIT 5;

-- 4) Clientes com maior gasto total (ranking)
SELECT c.idcliente, c.nome, COUNT(p.idpedido) AS compras, SUM(p.valortotal) AS gasto_total
FROM cliente c
JOIN pedido p ON p.idcliente = c.idcliente
WHERE p.statuspedido <> 'cancelado'
GROUP BY c.idcliente, c.nome
ORDER BY gasto_total DESC
LIMIT 10;

-- 5) Produtos com estoque baixo (threshold = 5)
SELECT v.idvariacao, v.sku, pr.nome AS produto, v.cor, v.tamanho, v.quantidadeestoque
FROM variacao v
JOIN produto pr ON v.idproduto = pr.idproduto
WHERE v.quantidadeestoque <= 5
ORDER BY v.quantidadeestoque ASC;

-- vendas por mes (ultimos 6 meses)
SELECT date_trunc('month', p.datapedido) AS mes, COUNT(*) AS pedidos, SUM(p.valortotal) AS receita
FROM pedido p
WHERE p.datapedido >= now() - interval '6 month'
  AND p.statuspedido NOT IN ('cancelado')
GROUP BY 1
ORDER BY 1 DESC;
