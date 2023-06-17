-- Window functions with OVER
SELECT 
	[BusinessEntityID]
	,[TerritoryID]
	,[SalesLastYear]
	,[Total YTD Sales] = SUM([SalesYTD]) OVER()
	,[Max YTD Sales] = MAX([SalesYTD]) OVER()
	,[% of Best Performer] = [SalesYTD] / MAX([SalesYTD]) OVER()
FROM [AdventureWorks2022].[Sales].[SalesPerson];

-- Using aggregate functions
SELECT
	MAX([SalesYTD])
FROM [AdventureWorks2022].[Sales].[SalesPerson];


-- Exercise
SELECT p.[FirstName]
	,p.[LastName] 
	,e.[JobTitle]
	,eph.[Rate]
	,[AverateRate] = AVG(eph.[Rate]) OVER()
	,[MaxRate] = MAX(eph.[Rate]) OVER()
	,[DiffFromAvgRate] = eph.[Rate] - AVG(eph.[Rate]) OVER()
	,[PercentofMaxRate] = (eph.[Rate] / MAX(eph.[Rate]) OVER()) * 100
FROM [AdventureWorks2022].[Person].[Person] AS p
JOIN [AdventureWorks2022].[HumanResources].[Employee] AS e 
	ON p.BusinessEntityID = e.BusinessEntityID
JOIN [AdventureWorks2022].[HumanResources].[EmployeePayHistory] AS eph
	ON e.BusinessEntityID = eph.BusinessEntityID
