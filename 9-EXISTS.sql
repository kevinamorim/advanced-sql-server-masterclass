USE [AdventureWorks2022]
GO

--SELECT * FROM Sales.SalesOrderHeader WHERE SalesOrderID = 43683
--SELECT * FROM Sales.SalesOrderDetail WHERE SalesOrderID = 43683

-- With join
--SELECT 
--	A.SalesOrderID
--	,A.OrderDate
--	,A.TotalDue
--	,B.SalesOrderDetailID
--	,B.LineTotal
--FROM Sales.SalesOrderHeader A 
--	INNER JOIN Sales.SalesOrderDetail B
--		ON A.SalesOrderID = B.SalesOrderID
--WHERE B.LineTotal > 10000
--ORDER BY 1

-- With exists
--SELECT 
--	A.SalesOrderID
--	,A.OrderDate
--	,A.TotalDue

--FROM Sales.SalesOrderHeader A 
--WHERE EXISTS 
--	(
--		SELECT 1 FROM Sales.SalesOrderDetail 
--			WHERE LineTotal > 10000 AND SalesOrderID = A.SalesOrderID
--	)
--ORDER BY 1

--SELECT 
--	A.SalesOrderID
--	,A.OrderDate
--	,A.TotalDue

--FROM Sales.SalesOrderHeader A 
--WHERE NOT EXISTS 
--	(
--		SELECT 1 FROM Sales.SalesOrderDetail 
--			WHERE LineTotal > 10000 AND SalesOrderID = A.SalesOrderID
--	)
--ORDER BY 1


-- Exercises

SELECT 
	--PurchaseOrderID
	--,OrderDate
	--,SubTotal
	--,TaxAmt
	*
FROM Purchasing.PurchaseOrderHeader A
WHERE EXISTS 
(
	SELECT 1 FROM Purchasing.PurchaseOrderDetail
	WHERE PurchaseOrderID = A.PurchaseOrderID
		AND OrderQty > 500 AND UnitPrice > 50
)

SELECT 
	--PurchaseOrderID
	--,OrderDate
	--,SubTotal
	--,TaxAmt
	*
FROM Purchasing.PurchaseOrderHeader A
WHERE NOT EXISTS 
(
	SELECT 1 FROM Purchasing.PurchaseOrderDetail
	WHERE PurchaseOrderID = A.PurchaseOrderID
		AND RejectedQty > 0
)