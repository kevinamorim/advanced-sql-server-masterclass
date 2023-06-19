USE [AdventureWorks2022]
GO

-- WITH PARTITION
--SELECT
--	[SalesOrderID]
--	,[SalesOrderDetailID]
--	,[LineTotal]
--	,[ProductIDLineTotal] = SUM([LineTotal]) OVER (PARTITION BY [SalesOrderID])
--	,[Ranking] = ROW_NUMBER() OVER (PARTITION BY [SalesOrderID] ORDER BY [LineTotal])

--FROM [Sales].[SalesOrderDetail]
--ORDER BY [SalesOrderID]

-- WITHOUT PARTITION
--SELECT
--	[SalesOrderID]
--	,[SalesOrderDetailID]
--	,[LineTotal]
--	,[ProductIDLineTotal] = SUM([LineTotal]) OVER (PARTITION BY [SalesOrderID])
--	,[Ranking] = ROW_NUMBER() OVER (ORDER BY [LineTotal])

--FROM [Sales].[SalesOrderDetail]
--ORDER BY 5

SELECT
	p.[Name] AS ProductName
	,p.[ListPrice]
	,ps.[Name] AS ProductSubcategory
	,pc.[Name] AS ProductCategory
	,[PriceRank] = ROW_NUMBER() OVER (ORDER BY [ListPrice] DESC)
	,[CategoryPriceRank] = ROW_NUMBER() OVER( PARTITION BY pc.[Name] ORDER BY [ListPrice] DESC)
	,[Top5PriceInCategory] = 
		CASE
			WHEN ROW_NUMBER() OVER( PARTITION BY pc.[Name] ORDER BY [ListPrice] DESC) <= 5 THEN 'Yes'
			ELSE 'No'
		END
	FROM [Production].[Product] AS p
	JOIN [Production].[ProductSubcategory] AS ps 
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN [Production].[ProductCategory] AS pc
		ON ps.ProductCategoryID = pc.ProductCategoryID;