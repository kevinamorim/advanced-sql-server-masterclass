-- Aggregate function
SELECT
	[ProductID]
	,[OrderQty]
	,[LineTotal] = SUM([LineTotal])
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]
GROUP BY
	[ProductID]
	,[OrderQty]
ORDER BY 1, 2 DESC

-- Via OVER
SELECT
	[ProductID]
	,[OrderQty]
	,[UnitPrice]
	,[ProductIDLineTotal] = SUM([LineTotal]) OVER(PARTITION BY [ProductID], [OrderQty])
FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]
ORDER BY [ProductID], [OrderQty] DESC

-- Exercise

SELECT
	p.[Name] AS ProductName 
	,p.[ListPrice]
	,ps.[Name] AS ProductSubcategory
	,pc.[Name] AS ProductCategory
	,[AvgPriceByCategory] = AVG(p.[ListPrice]) OVER(PARTITION BY pc.ProductCategoryId)
	,[AvgPriceByCategoryAndSubcategory] = AVG(p.[ListPrice]) OVER (PARTITION BY pc.ProductCategoryId, ps.ProductSubcategoryId)
	,[ProductVsCategoryDelta] = p.[ListPrice] - AVG(p.[ListPrice]) OVER (PARTITION BY pc.ProductCategoryId)
FROM [AdventureWorks2022].[Production].[Product] AS p
INNER JOIN [AdventureWorks2022].[Production].[ProductSubcategory] AS ps
	ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [AdventureWorks2022].[Production].[ProductCategory] as pc
	ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY ProductName DESC