-- 1) Atualizar status de pedido para 'enviado' e inserir código de rastreio
UPDATE pedido
SET statuspedido = 'enviado', codigorastreamento = 'RBT123456789BR'
WHERE idpedido = 3 AND statuspedido = 'em_processamento';

-- 2) Corrigir preço base de um produto (ajuste promocional)
UPDATE produto
SET precobase = precobase * 0.9
WHERE idproduto = 1; -- aplicar 10% off ao produto 1

-- 3) Repor estoque para uma variação específica
UPDATE variacao
SET quantidadeestoque = quantidadeestoque + 20
WHERE sku = 'VFL-001-M-ROSA';
