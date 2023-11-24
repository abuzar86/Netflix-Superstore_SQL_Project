/* 
Superstore Data Exploration Project using SQL Server and Tableau Desktop
Teuku Abuzar Akbar
November 22, 2023
*/

-- Load the Data
SELECT * 
FROM PortfolioProject..Superstore_data$

SELECT *
FROM PortfolioProject..Superstore_profit$ 

-- Total sales and total profits of each year.
Select Year(a.[Order Date]) as Year, sum(a.Sales) Total_Sales, 
	   sum(b.Profit) as Total_Profit
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID]= b.[Order ID]
Group BY Year(a.[Order Date])
Order by Year(a.[Order Date]) DESC

-- Trends permonth by year
SELECT   
	DATENAME(MONTH, a.[Order Date]) AS Monthly, SUM(a.Sales) AS Total_Sales,
	SUM(b.Profit) AS Total_Profit
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID] = b.[Order ID]
WHERE 
    YEAR(a.[Order Date]) = 2017 -- The years can be adjusted to observe monthly trends each year.
GROUP BY  DATENAME(MONTH, a.[Order Date]), MONTH(a.[Order Date])
ORDER BY MONTH(a.[Order Date]) ASC;

-- The Highest Sales and Profit by Region
SELECT a.Region, SUM(a.Sales) as Total_Sales, SUM(b.Profit) as Total_Profit,
	   ROUND(SUM(b.Profit)/SUM(a.Sales)*100,2) as Profit_Margin
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID]= b.[Order ID]
GROUP BY a.Region
ORDER BY SUM(b.Profit) DESC

-- State and city brings in the highest sales and profits

-- Top 5 State 
SELECT a.State, SUM(a.Sales) as Total_Sales, SUM(b.Profit) as Total_Profit,
	   ROUND(SUM(b.Profit)/SUM(a.Sales)*100,2) as Profit_Margin
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID]= b.[Order ID]
GROUP BY a.State
ORDER BY SUM(b.Profit) DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY
-- Bottom 5 State
SELECT a.State, SUM(a.Sales) as Total_Sales, SUM(b.Profit) as Total_Profit,
	   ROUND(SUM(b.Profit)/SUM(a.Sales)*100,2) as Profit_Margin
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID]= b.[Order ID]
GROUP BY a.State
ORDER BY SUM(b.Profit) ASC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

-- Top 5 cities
SELECT a.City, SUM(a.Sales) as Total_Sales, SUM(b.Profit) as Total_Profit,
	   ROUND(SUM(b.Profit)/SUM(a.Sales)*100,2) as Profit_Margin
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID]= b.[Order ID]
GROUP BY a.City
ORDER BY SUM(b.Profit) DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

-- Bottom 5 cities
SELECT a.City, SUM(a.Sales) as Total_Sales, SUM(b.Profit) as Total_Profit,
	   ROUND(SUM(b.Profit)/SUM(a.Sales)*100,2) as Profit_Margin
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID]= b.[Order ID]
GROUP BY a.City
ORDER BY SUM(b.Profit) ASC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

-- The highest sales and profits in each category
SELECT a.Category, SUM(a.Sales) Total_Sales, SUM(b.Profit) Total_Profit
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID] = b.[Order ID]
GROUP BY a.Category
ORDER BY SUM(b.Profit) DESC

-- The highest category profit in each region
SELECT a.Region, a.Category, a.[Sub-Category], SUM(b.Profit) Total_Profit 
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID] = b.[Order ID]
GROUP BY a.Region, a.Category, a.[Sub-Category]
ORDER BY SUM(b.Profit) DESC

-- -- The highest category profit in each states
SELECT a.State, a.Category, a.[Sub-Category], SUM(b.Profit) Total_Profit 
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID] = b.[Order ID]
GROUP BY a.State, a.Category, a.[Sub-Category]
ORDER BY SUM(b.Profit) DESC

-- Names of the products that are the most and least profitable.
SELECT a.[Product Name], a.[Sub-Category], SUM(b.Profit) Total_profit
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID] = b.[Order ID]
GROUP BY a.[Product Name], a.[Sub-Category]
ORDER BY SUM(b.Profit) DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

-- What segment makes the most of our profits and sales ?
SELECT a.Segment, SUM(a.Sales) Total_Sales, SUM(b.Profit) Total_Profit
FROM PortfolioProject..Superstore_data$ a
JOIN PortfolioProject..Superstore_profit$ b
ON a.[Order ID] = b.[Order ID]
GROUP BY a.Segment
ORDER BY SUM(b.Profit) DESC

-- Customer information
SELECT COUNT(DISTINCT([Customer ID])) Total_Customer
FROM PortfolioProject..Superstore_data$

-- Total customer in each Region and state
SELECT Region, COUNT(DISTINCT([Customer ID])) Total_Customer 
FROM PortfolioProject..Superstore_data$
GROUP BY Region
Order BY COUNT(DISTINCT([Customer ID])) DESC

SELECT State, COUNT(DISTINCT([Customer ID])) Total_Customer 
FROM PortfolioProject..Superstore_data$
GROUP BY State
Order BY COUNT(DISTINCT([Customer ID])) DESC

-- The shipping time in each shipping mode
SELECT [Ship Mode],
       ROUND(AVG(DATEDIFF(day, [Order Date], [Ship Date])), 1) AS avg_shipping_time
FROM PortfolioProject..Superstore_data$
GROUP BY [Ship Mode]
ORDER BY avg_shipping_time DESC;



