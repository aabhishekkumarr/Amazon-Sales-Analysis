-- ===============================
-- Amazon Sales Analysis Project
-- ===============================
-- create database amazone_sales;
USE amazone_sales;
-- then make table 
-- CREATE TABLE amazon_sales (
--  OrderID VARCHAR(50),
--    OrderDate DATE,
 --   CustomerID VARCHAR(50),
--    CustomerName VARCHAR(100),
 --   ProductID VARCHAR(50),
--    ProductName VARCHAR(255),
 --   Category VARCHAR(100),
 --   Brand VARCHAR(100),
--    Quantity INT,
--    UnitPrice DECIMAL(10,2),
--    Discount DECIMAL(10,2),
--    Tax DECIMAL(10,2),
--    TotalAmount DECIMAL(12,2),
--    PaymentMethod VARCHAR(50),
--    OrderStatus VARCHAR(50),
--    City VARCHAR(100),
--    State VARCHAR(100),
--    SellerID VARCHAR(50)
-- );
SELECT * FROM amazon_sales;
SELECT * FROM amazon_sales LIMIT 5;
-- THEN, DATASET OVERVIEW
SELECT
count(*) AS total_rows,
count(DISTINCT OrderID) AS total_orders,
count(DISTINCT CustomerID) AS total_customers,
count(DISTINCT ProductID) AS total_products
FROM amazon_sales;
-- SET DATE RANGE
SELECT
    MIN(OrderDate) AS start_date,
    MAX(OrderDate) AS end_date
FROM amazon_sales;
-- TOTAL REVENUE
SELECT
    ROUND(SUM(TotalAmount), 2) AS total_revenue
FROM amazon_sales;
-- AVERAGE ORDER VALUE 
SELECT
    COUNT(DISTINCT OrderID) AS total_orders,
    ROUND(SUM(TotalAmount) / COUNT(DISTINCT OrderID), 2) AS avg_order_value
FROM amazon_sales;
-- MONTHLY REVENUE 
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    ROUND(SUM(TotalAmount), 2) AS monthly_revenue
FROM amazon_sales
GROUP BY month
ORDER BY month;
-- TOP PRODUCT BY REVENUE
SELECT
    ProductName,
    ROUND(SUM(TotalAmount), 2) AS revenue
FROM amazon_sales
GROUP BY ProductName
ORDER BY revenue DESC
LIMIT 10;
-- CATEGORY WISE REVENUE
SELECT
    Category,
    ROUND(SUM(TotalAmount), 2) AS revenue
FROM amazon_sales
GROUP BY Category
ORDER BY revenue DESC;
-- REPEAT V\S ONE-TIME CUSTOMER
SELECT
    customer_type,
    COUNT(*) AS customers
FROM (
    SELECT
        CustomerID,
        CASE
            WHEN COUNT(DISTINCT OrderID) > 1 THEN 'Repeat'
            ELSE 'One-time'
        END AS customer_type
    FROM amazon_sales
    GROUP BY CustomerID
) t
GROUP BY customer_type;
-- TOP CUSTOMER BT SPEND
SELECT
    CustomerID,
    CustomerName,
    ROUND(SUM(TotalAmount), 2) AS total_spent
FROM amazon_sales
GROUP BY CustomerID, CustomerName
ORDER BY total_spent DESC
LIMIT 10;
-- ORDER STATUS
SELECT
    OrderStatus,
    COUNT(*) AS orders
FROM amazon_sales
GROUP BY OrderStatus;
--  AVERAGE AND TOTAL SHIPPING COST
SELECT
    ROUND(AVG(ShippingCost), 2) AS avg_shipping_cost,
    ROUND(SUM(ShippingCost), 2) AS total_shipping_cost
FROM amazon_sales;
-- DISCOUNT THORUGH REVENUE
SELECT
    CASE
        WHEN Discount > 0 THEN 'Discounted'
        ELSE 'No Discount'
    END AS discount_type,
    ROUND(SUM(TotalAmount), 2) AS revenue
FROM amazon_sales
GROUP BY discount_type;
