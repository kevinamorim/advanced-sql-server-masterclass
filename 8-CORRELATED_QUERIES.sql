USE [AdventureWorks2022]
GO

--SELECT
--	SalesOrderID
--	,OrderDate
--	,SubTotal
--	,TaxAmt
--	,Freight
--	,TotalDue
--	,MultiOrderCount = 
--			(SELECT COUNT(SalesOrderID)
--			FROM Sales.SalesOrderDetail 
--			WHERE SalesOrderID = A.SalesOrderID AND
--				OrderQty > 1)

--FROM Sales.SalesOrderHeader A


--SELECT COUNT(SalesOrderID)
--FROM Sales.SalesOrderDetail 
--WHERE SalesOrderID = 43659 AND
--	OrderQty > 1


-- Exercises

SELECT PurchaseOrderID, VendorID, OrderDate, TotalDue,
	NonRejectedItems = 
	(
		SELECT COUNT(*) FROM Purchasing.PurchaseOrderDetail
			WHERE RejectedQty = 0 AND PurchaseOrderID = A.PurchaseOrderID
	),
	MostExpensiveItem = 
	(
		SELECT MAX(UnitPrice) FROM Purchasing.PurchaseOrderDetail
			WHERE PurchaseOrderID = A.PurchaseOrderID
	)
FROM Purchasing.PurchaseOrderHeader A
