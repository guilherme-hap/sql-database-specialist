USE ecommerce;

-- Retorna cnpj e contato de fornecedores com o nome começando com 'Eletrônicos'
SELECT
	cnpj, contact
FROM
	suppliers
WHERE
	businessName LIKE 'Eletrônicos%';
    
-- Retorna todos os dados dos pedidos que possuem frete
SELECT
	*
FROM
	orders
WHERE
	shipping IS NOT NULL;
    
-- Retorna status, nome, descrição e quantidade de um pedido e nome e avaliação dos produtos pedidos em compras feitas pelo aplicativo
SELECT
	pName AS Nome, pOrderQuantity AS Quantidade, rating AS Avaliação, orderStatus AS Status_da_compra, orderDescription AS Descrição 
FROM
	orders INNER JOIN productsOrders ON orderId = ordersOrderId INNER JOIN products ON productId = productsProductId
WHERE
	orderDescription LIKE '%aplicativo%';
    
-- Retorna status do pedido, nome do produto, quantidade de produtos do pedido, frete e novo valor do frete com taxa de um pedido
SELECT
	pName AS Nome, pOrderQuantity AS Quantidade, orderStatus AS Status_da_compra, shipping AS Frete, ROUND((shipping * pOrderQuantity * 1.15), 2) AS Frete_com_taxa
FROM
	orders INNER JOIN productsOrders ON orderId = ordersOrderId INNER JOIN products ON productId = productsProductId
WHERE
	shipping IS NOT NULL;
    
-- Retorna o número de pedido feitos por cada cliente, além do nome, endereço e status da compra
SELECT
	CONCAT(fName, ' ', lName) as Nome, address as Endereço, orderStatus as Status_da_compra, COUNT(*) AS Quantidade_de_pedidos
FROM
	clients INNER JOIN orders ON clientId = orderIdClient
GROUP BY
	clientId, orderStatus
ORDER BY
	Quantidade_de_Pedidos;
    
-- Retorna os vendedores que também são fornecedores
SELECT
	se.tradeName AS Nome_fantasia, su.businessName AS Razão_social, se.cnpj AS CNPJ
FROM
	sellers AS se, suppliers AS su
WHERE 
	se.cnpj = su.cnpj;

-- Retorna a relação entre produtos, fornecedores e estoques
SELECT
	p.pName AS Nome_do_produto, psu.quantity AS Quantidade, su.businessName AS Fornecedor, storageLocation AS Local_de_estoque
FROM
	products AS p
    INNER JOIN productsSuppliers AS psu
    ON p.productId = psu.productsProductId 
    INNER JOIN suppliers AS su
    ON su.supplierId = psu.suppliersSupplierId
    INNER JOIN storageLocations AS sl
    ON p.productId = sl.productsProductId
    INNER JOIN productsStorage AS ps
    ON pStoragePStorageId = ps.prodStorageId
ORDER BY
	psu.quantity;

-- Retorna a relação dos nomes dos fornecedores e dos nomes dos produtos e quantidades
SELECT
	pName AS Nome, businessName AS Fornecedor, quantity AS Quantidade
FROM
	products
    INNER JOIN productsSuppliers
    ON productId = productsProductId
    INNER JOIN suppliers
    ON supplierId = suppliersSupplierId;

-- Retorna a relação dos nomes dos fornecedores e dos nomes dos produtos e quantidades que forem mais do que 450 unidades
SELECT
	pName AS Nome, businessName AS Fornecedor, quantity AS Quantidade
FROM
	products
    INNER JOIN productsSuppliers
    ON productId = productsProductId
    INNER JOIN suppliers
    ON supplierId = suppliersSupplierId
GROUP BY
	businessName, pName, quantity
HAVING
	quantity > 450;
	
    

    
