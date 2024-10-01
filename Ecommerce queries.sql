USE ecommerce_db;

SELECT * FROM ecommerce_data_clean;

-- 1. Total sales over time 

-- Sales by month
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM ecommerce_data
GROUP BY Month
ORDER BY Month;

-- Sales by quater 
SELECT QUARTER(InvoiceDate) AS Quarter, 
       YEAR(InvoiceDate) AS Year, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM ecommerce_data
GROUP BY Year, Quarter
ORDER BY Year, Quarter;

-- Sales by year 
SELECT YEAR(InvoiceDate) AS Year, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM ecommerce_data
GROUP BY Year
ORDER BY Year;

-- 2. Best and worst days for sales 

SELECT DAYNAME(InvoiceDate) AS DayOfWeek, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM ecommerce_data
GROUP BY DayOfWeek
ORDER BY TotalSales DESC;

-- 3. Top customers by revenue 

SELECT CustomerID, 
       SUM(Quantity * UnitPrice) AS TotalRevenue
FROM ecommerce_data
GROUP BY CustomerID
ORDER BY TotalRevenue DESC
LIMIT 10;

-- 4. Best-selling products 

SELECT Description, 
       SUM(Quantity) AS TotalUnitsSold
FROM ecommerce_data
GROUP BY Description
ORDER BY TotalUnitsSold DESC
LIMIT 10;

-- 5. Sales by country 

SELECT Country, 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM ecommerce_data
GROUP BY Country
ORDER BY TotalSales DESC;

-- 6. New vs. Returning customers

WITH FirstPurchase AS (
    SELECT CustomerID, MIN(InvoiceDate) AS FirstPurchaseDate
    FROM ecommerce_data
    GROUP BY CustomerID
)
SELECT CASE
           WHEN ecommerce_data.InvoiceDate = FirstPurchase.FirstPurchaseDate THEN 'New'
           ELSE 'Returning'
       END AS CustomerType, 
       COUNT(DISTINCT ecommerce_data.CustomerID) AS CustomerCount
FROM ecommerce_data
JOIN FirstPurchase ON ecommerce_data.CustomerID = FirstPurchase.CustomerID
GROUP BY CustomerType;

-- 7. Product return rate

SELECT Description, 
       SUM(CASE WHEN Quantity < 0 THEN ABS(Quantity) ELSE 0 END) AS TotalReturns,
       SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END) AS TotalSold,
       (SUM(CASE WHEN Quantity < 0 THEN ABS(Quantity) ELSE 0 END) / SUM(CASE WHEN Quantity > 0 THEN Quantity ELSE 0 END)) * 100 AS ReturnRate
FROM ecommerce_data
GROUP BY Description
ORDER BY ReturnRate DESC;

-- 8. Customer lifettime value 

SELECT CustomerID, 
       SUM(Quantity * UnitPrice) AS LifetimeValue
FROM ecommerce_data
GROUP BY CustomerID
ORDER BY LifetimeValue DESC;

-- 9. Sales Trends by product over time 

SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, 
       Description, 
       SUM(Quantity) AS TotalUnitsSold
FROM ecommerce_data
GROUP BY Month, Description
ORDER BY Month, TotalUnitsSold DESC;

-- 10. Average order value 

SELECT InvoiceNo, 
       SUM(Quantity * UnitPrice) AS OrderValue
FROM ecommerce_data
GROUP BY InvoiceNo;

SELECT AVG(OrderValue) AS AverageOrderValue
FROM (SELECT InvoiceNo, 
             SUM(Quantity * UnitPrice) AS OrderValue
      FROM ecommerce_data
      GROUP BY InvoiceNo) AS OrderValues;

