SELECT * FROM superstore_raw LIMIT 10;

DESCRIBE superstore_raw;

SELECT COUNT(*) FROM superstore_raw;

CREATE TABLE superstore_clean AS
SELECT * FROM superstore_raw;

ALTER TABLE superstore_clean
MODIFY `Order Date` DATE,
MODIFY `Ship Date` DATE;

DESCRIBE superstore_clean;

DROP TABLE superstore_clean;

CREATE TABLE superstore_clean AS
SELECT 
    `Row ID`,
    `Order ID`,
    STR_TO_DATE(`Order Date`, '%m/%d/%Y') AS order_date,
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y') AS ship_date,
    `Ship Mode`,
    `Customer ID`,
    `Customer Name`,
    `Segment`,
    `Country`,
    `City`,
    `State`,
    `Postal Code`,
    `Region`,
    `Product ID`,
    `Category`,
    `Sub-Category`,
    `Product Name`,
    CAST(Sales AS FLOAT) AS sales,
    Quantity,
    CAST(Discount AS FLOAT) AS discount,
    CAST(Profit AS FLOAT) AS profit
FROM superstore_raw;

DESCRIBE superstore_clean;

SELECT `Order ID`, COUNT(*) 
FROM superstore_clean
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

SELECT *
FROM superstore_clean
WHERE sales IS NULL 
   OR profit IS NULL 
   OR order_date IS NULL;
   
   SELECT *
FROM superstore_clean
WHERE `Product Name` = '' 
   OR `Customer Name` = '';
   
   DESCRIBE superstore_clean;
   
   SELECT * FROM superstore_clean
LIMIT 10;

SELECT COUNT(*) FROM superstore_clean;

SELECT 
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales
FROM superstore_clean;
   
SELECT 
    MIN(profit) AS min_profit,
    MAX(profit) AS max_profit
FROM superstore_clean;

SELECT 
    Region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean
GROUP BY Region
ORDER BY total_sales DESC;

SELECT 
    Category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean
GROUP BY Category
ORDER BY total_profit DESC;

SELECT 
    `Product Name`,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
    `Product Name`,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean
GROUP BY `Product Name`
ORDER BY total_profit ASC
LIMIT 10;

SELECT 
    Segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean
GROUP BY Segment
ORDER BY total_sales DESC;

SELECT 
    discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean
GROUP BY discount
ORDER BY discount;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore_clean
GROUP BY month
ORDER BY month;

SELECT 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) AS total_orders,
    ROUND(AVG(sales), 2) AS avg_order_value
FROM superstore_clean;