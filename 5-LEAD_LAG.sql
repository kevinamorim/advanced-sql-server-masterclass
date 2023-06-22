USE [AdventureWorks2022]
GO

--SELECT
--	[SalesOrderId]
--	,[OrderDate]
--	,[CustomerID]
--	,[TotalDue]
--	,[NextTotalDue] = LEAD([TotalDue], 1) OVER(PARTITION BY [CustomerID] ORDER BY [SalesOrderID])
--	,[PreviousTotalDue] = LAG([TotalDue], 1) OVER(PARTITION BY [CustomerID] ORDER BY [SalesOrderID])
--FROM [Sales].[SalesOrderHeader]

----ORDER BY [SalesOrderID]
--ORDER BY [CustomerID], [SalesOrderID]

SELECT
	A.[PurchaseOrderID]
	,A.[OrderDate]
	,A.[TotalDue]
	,B.[Name] AS [VendorName]
	,[PrevOrderFromVendorAmt] = LAG(A.[TotalDue], 1) OVER(PARTITION BY B.[Name] ORDER BY [OrderDate])
	,[NextOrderByEmployeeVendor] = LEAD(B.[Name], 1) OVER(PARTITION BY A.[EmployeeID] ORDER BY [OrderDate])
	,[Next2OrderByEmployeeVendor] = LEAD(B.[Name], 2) OVER(PARTITION BY A.[EmployeeID] ORDER BY [OrderDate])
FROM [Purchasing].[PurchaseOrderHeader] AS A
JOIN [Purchasing].[Vendor] AS B
ON A.VendorID = B.BusinessEntityID

WHERE YEAR(A.[OrderDate]) >= 2013
	AND A.[TotalDue] > 500
ORDER BY A.EmployeeID, A.OrderDate

