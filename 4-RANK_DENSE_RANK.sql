USE [AdventureWorks2022]
GO

--SELECT
--	[SalesOrderID]
--	,[SalesOrderDetailID]
--	,[LineTotal]
--	,Ranking = ROW_NUMBER() OVER ( PARTITION BY [SalesOrderID] ORDER BY [LineTotal] DESC )
--	,RankingWithRank = RANK() OVER ( PARTITION BY [SalesOrderID] ORDER BY [LineTotal] DESC )
--	,RankingWithDense = DENSE_RANK() OVER ( PARTITION BY [SalesOrderID] ORDER BY [LineTotal] DESC )
--FROM [Sales].[SalesOrderDetail]
--ORDER BY [SalesOrderID], [LineTotal] DESC



-- Exercise
SELECT
	p.[Name] AS ProductName
	,p.[ListPrice]
	,ps.[Name] AS ProductSubcategory
	,pc.[Name] AS ProductCategory
	,[PriceRank] = ROW_NUMBER() OVER (ORDER BY [ListPrice] DESC)
	,[CategoryPriceRank] = ROW_NUMBER() OVER( PARTITION BY pc.[Name] ORDER BY [ListPrice] DESC)
	,[Top5PriceInCategory] = 
		CASE
			WHEN DENSE_RANK() OVER( PARTITION BY pc.[Name] ORDER BY [ListPrice] DESC) <= 5 THEN 'Yes'
			ELSE 'No'
		END
	,[Category Price Rank With Rank] = RANK() OVER (PARTITION BY pc.[Name] ORDER BY [ListPrice] DESC)
	,[Category Price Rank With Dense Rank] = DENSE_RANK() OVER (PARTITION BY pc.[Name] ORDER BY [ListPrice] DESC)
	FROM [Production].[Product] AS p
	JOIN [Production].[ProductSubcategory] AS ps 
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN [Production].[ProductCategory] AS pc
		ON ps.ProductCategoryID = pc.ProductCategoryID;