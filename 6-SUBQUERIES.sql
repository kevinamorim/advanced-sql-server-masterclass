USE [AdventureWorks2022]
GO

--SELECT * FROM
--	(
--	SELECT
--		[SalesOrderID]
--		,[SalesOrderDetailID]
--		,[LineTotal]
--		,LineTotalRanking = ROW_NUMBER() OVER (PARTITION BY [SalesOrderID] ORDER BY [LineTotal] DESC)

--	FROM [Sales].[SalesOrderDetail]
--	) A
--WHERE [LineTotalRanking] = 1


SELECT * FROM
(
SELECT 
	[PurchaseOrderID]
	,[VendorID]
	,[OrderDate]
	,[TaxAmt]
	,[Freight]
	,[TotalDue]
	,[Top] = DENSE_RANK() OVER (PARTITION BY [VendorID] ORDER BY [TotalDue] DESC)
	FROM [Purchasing].[PurchaseOrderHeader]
) A
WHERE [Top] <= 3