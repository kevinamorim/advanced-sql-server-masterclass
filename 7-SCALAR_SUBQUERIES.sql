USE [AdventureWorks2022]
GO

--SELECT
--	[ProductID]
--	,[Name]
--	,[StandardCost]
--	,[ListPrice]
--	,[AvgListPrice] = (SELECT AVG([ListPrice]) FROM [Production].[Product])
--	,[AvgListPriceDiff] = [ListPrice] - (SELECT AVG([ListPrice]) FROM [Production].[Product])

--FROM [Production].[Product]

--WHERE [ListPrice] > (SELECT AVG([ListPrice]) FROM [Production].[Product])

--ORDER BY [ListPrice]

-- Exercise

SELECT 
	[BusinessEntityID]
	,[JobTitle]
	,[VacationHours]
	,[MaxVacationHours] = (SELECT MAX([VacationHours]) FROM [HumanResources].[Employee])
	,[PercentageOfVacationHours] = [VacationHours] * 1.0 / (SELECT MAX([VacationHours]) FROM [HumanResources].[Employee])
FROM [HumanResources].[Employee]
WHERE ([VacationHours] * 1.0 / (SELECT MAX([VacationHours]) FROM [HumanResources].[Employee])) > 0.8
ORDER BY [VacationHours] DESC