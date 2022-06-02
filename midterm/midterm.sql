------------------------- Task 1 -------------------------
SELECT DimCustomer.CustomerKey,CONCAT(FirstName ,' ',MiddleName,' ',LastName) as FullName , 
	   Count(FactInternetSales.ProductKey) as SalesOrderNumber
FROM DimCustomer
JOIN FactInternetSales ON DimCustomer.CustomerKey = FactInternetSales.CustomerKey
GROUP BY DimCustomer.CustomerKey,FirstName,MiddleName,LastName;

------------------------- Task 2 -------------------------
with foo as 
	(SELECT DISTINCT 
		(Case 
			When Color = 'Black' OR Color = 'Silver' OR Color = 'Silver/Black' THEN 'Basic'
			ELSE Color
		END) as Color_Group , SUM(ListPrice) as SalesAmount 
	From DimProduct
	WHERE Color IS NOT NULL
	Group by Color)
select Color_Group,CONCAT(SUM(SalesAmount),' $') as SalesAmount from foo
group by Color_Group;

------------------------- Task 3 -------------------------
SELECT ProductKey,OrderDate,ShipDate,SalesType = 'Internet'
FROM FactInternetSales
WHERE (DATEPART(yy, ShipDate) = 2011
AND    DATEPART(mm, ShipDate) = 10)
GROUP BY ProductKey,OrderDate,ShipDate
UNION
Select ProductKey,OrderDate,ShipDate ,SalesType = 'Resell'
FROM FactResellerSales
WHERE (DATEPART(yy, ShipDate) = 2011
AND    DATEPART(mm, ShipDate) = 10)
GROUP BY ProductKey,OrderDate,ShipDate;

------------------------- Task 4 -------------------------
select dbo.FactInternetSales.ProductKey, dbo.DimProduct.EnglishProductName, SalesType = 'Internet', 
	   sum(dbo.FactInternetSales.OrderQuantity) as TotalOrderQuantity
from dbo.FactInternetSales
join dbo.DimProduct on dbo.FactInternetSales.ProductKey = dbo.DimProduct.ProductKey
WHERE (DATEPART(yy, dbo.FactInternetSales.OrderDate) = 2013
AND    DATEPART(mm, dbo.FactInternetSales.OrderDate) between 7 and 9)
group by dbo.FactInternetSales.ProductKey, dbo.DimProduct.EnglishProductName
union
select dbo.FactResellerSales.ProductKey, dbo.DimProduct.EnglishProductName, SalesType = 'Reseller', 
	   sum(dbo.FactResellerSales.OrderQuantity)
from dbo.FactResellerSales
join dbo.DimProduct on dbo.FactResellerSales.ProductKey = dbo.DimProduct.ProductKey
WHERE (DATEPART(yy, dbo.FactResellerSales.OrderDate) = 2013
AND    DATEPART(mm, dbo.FactResellerSales.OrderDate) between 7 and 9)
group by dbo.FactResellerSales.ProductKey, dbo.DimProduct.EnglishProductName;