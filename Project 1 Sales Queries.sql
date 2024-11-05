Create Database Sales_Dataset

select * from [dbo].[Sales Capstone Dataset]
 
----retrieve total price for each product category----
 
----to get totalprice for shirt product----
 
select sum(total_price) as TotalProduct from [dbo].[Sales Capstone Dataset]
where product = 'shirt'
 
----to get totalprice for shoes product----
 
select sum(total_price) as TotalProduct from [dbo].[Sales Capstone Dataset]
where product = 'shoes'
 
----to get totalprice for hat product----
 
select sum(total_price) as TotalProduct from [dbo].[Sales Capstone Dataset]
where product = 'hat'
 
----to get totalprice for jacket product----
 
select sum(total_price) as TotalProduct from [dbo].[Sales Capstone Dataset]
where product = 'jacket'
 
----to get totalprice for gloves product----
 
select sum(total_price) as TotalProduct from [dbo].[Sales Capstone Dataset]
where product = 'gloves'
 
----to get totalprice for socks product----
 
select sum(total_price) as TotalProduct from [dbo].[Sales Capstone Dataset]
where product = 'socks'
 
 
----Number 2----
----find the number of sales transactions in each region----
 
select * from [dbo].[Sales Capstone Dataset]
 
 
SELECT COUNT(OrderID) AS Region FROM [dbo].[Sales Capstone Dataset]
 
----find the highest-selling product by total sales value----
 
 
SELECT product, SUM(total_price) AS highestsellingproduct
FROM [dbo].[Sales Capstone Dataset]
GROUP BY product
ORDER BY highestsellingproduct DESC
 
 
----calculate total revenue per product---
 
SELECT product, SUM(total_price) AS total_revenue
FROM [dbo].[Sales Capstone Dataset]
GROUP BY product
ORDER BY total_revenue;
 
 
----calculate monthly sales totals for the current year----
 
SELECT YEAR(orderdate) AS sale_year,
       MONTH(orderdate) AS sale_month,
       SUM(quantity * unitprice) AS monthly_sales_total
FROM [dbo].[Sales Capstone Dataset]
WHERE YEAR(orderdate) = 2024
GROUP BY YEAR(orderdate), MONTH(orderdate)
ORDER BY sale_year, sale_month;
 
SELECT * FROM [dbo].[Sales Capstone Dataset]
 
----find the top 5 customers by total purchase amount---
 
SELECT customer_id, 
       SUM(quantity * unitprice) AS total_purchase_amount
FROM [dbo].[Sales Capstone Dataset]
GROUP BY customer_id
ORDER BY total_purchase_amount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
 
----calculate the percentage of total sales contributed by each region----
 
WITH RegionSales AS (
    SELECT region,
           SUM(quantity * unitprice) AS total_sales_by_region
    FROM [dbo].[Sales Capstone Dataset]
    GROUP BY region
),
TotalSales AS (
    SELECT SUM(quantity * unitprice) AS total_sales
    FROM [dbo].[Sales Capstone Dataset]
)
SELECT RS.region, 
       RS.total_sales_by_region,
       (RS.total_sales_by_region / TS.total_sales) * 100 AS percentage_of_total_sales
FROM RegionSales RS, TotalSales TS
ORDER BY percentage_of_total_sales DESC;
 
 
----identify products with no sales in the last quarter----
 
WITH LastQuarter AS (
    SELECT DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0) AS quarter_start,
           DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0) AS quarter_end
)
SELECT [dbo].[Sales Capstone Dataset].product
FROM [dbo].[Sales Capstone Dataset]
LEFT JOIN LastQuarter ON 1 = 1
LEFT JOIN [dbo].[Sales Capstone Dataset] AS SalesInLastQuarter
    ON [dbo].[Sales Capstone Dataset].product = SalesInLastQuarter.product
    AND SalesInLastQuarter.orderdate BETWEEN LastQuarter.quarter_start AND LastQuarter.quarter_end
WHERE SalesInLastQuarter.orderdate IS NULL
GROUP BY [dbo].[Sales Capstone Dataset].product;
 
