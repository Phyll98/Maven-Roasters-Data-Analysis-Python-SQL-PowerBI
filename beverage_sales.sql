
USE orders;

SELECT * 
FROM beverage_sales;

--describe the table schema
EXEC sp_columns beverage_sales;

--alter the data types
ALTER TABLE beverage_sales
ALTER COLUMN transaction_date DATE;

ALTER TABLE beverage_sales
ALTER COLUMN transaction_time TIME;

--checking for nulls
SELECT *
FROM beverage_sales
WHERE transaction_id is null
	or transaction_date is null
	or transaction_time is null
	or transaction_qty is null
	or store_id is null
	or store_location is null
	or product_id is null
	or unit_price is null
	or product_category is null
	or product_type is null
	or product_detail is null;

--checking for duplicates
SELECT *
FROM beverage_sales
WHERE COUNT(transaction_id)>1; 

--checking for outliers
SELECT
	MAX(transaction_id) as max_transaction_id,
	MIN(transaction_id) as min_transaction_id,
	MAX(transaction_date) as max_date,
	MIN(transaction_date) as min_date,
	MAX(transaction_time) as max_time,
	MIN(transaction_time) as max_time,
	MAX(transaction_qty) as max_qty,
	MIN(transaction_qty) as min_qty,
	MAX(store_id) as max_store_id,
	MIN(store_id) as min_store_id,
	MAX(product_id) as max_product_id,
	MIN(product_id) as min_product_id,
	MAX(unit_price) as max_price,
	MIN(unit_price) as min_price
FROM beverage_sales;

SELECT DISTINCT(store_location) as stores
FROM beverage_sales;

SELECT DISTINCT(product_category) as product_category
FROM beverage_sales;

SELECT DISTINCT(product_type) as product_type
FROM beverage_sales;

SELECT DISTINCT(product_detail) as product_detail
FROM beverage_sales;

--Exploratory Data Analysis
--Total Sales?
SELECT
	ROUND(SUM(transaction_qty * unit_price),2) as total_sales
FROM
	beverage_sales;

--Total quantity sold
SELECT 
	SUM(transaction_qty) as quantity_sold
FROM 
	beverage_sales;

--Daily Sales?
SELECT 
	transaction_date, 
	ROUND(SUM(transaction_qty * unit_price),2) AS daily_sales
FROM coffee_sales
GROUP BY 
	transaction_date
ORDER BY 
	transaction_date;

--Monthly Sales?
SELECT
	MONTH(transaction_date) as month,
	ROUND(SUM(transaction_qty * unit_price),2) AS monthly_sales
FROM
	beverage_sales
GROUP BY
	MONTH(transaction_date)
ORDER BY
	month;

--Top 10 selling products
SELECT TOP 10
	product_detail,
	SUM(transaction_qty) as quantity_sold
FROM beverage_sales
GROUP BY 
	product_detail
ORDER BY 
	quantity_sold DESC;

--Bottom 10 selling products
SELECT TOP 10
	product_detail,
	SUM(transaction_qty) as quantity_sold
FROM beverage_sales
GROUP BY 
	product_detail
ORDER BY 
	quantity_sold ASC;


--Top 10 products by revenue
SELECT TOP 10
	product_detail,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM beverage_sales
GROUP BY 
	product_detail
ORDER BY 
	total_sales DESC;

--Bottom 10 products by revenue
SELECT TOP 10
	product_detail,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM beverage_sales
GROUP BY 
	product_detail
ORDER BY 
	total_sales ASC;

--location with the highest sales
SELECT TOP 1
	store_location,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM
	beverage_sales
GROUP BY
	store_location
ORDER BY
	total_sales DESC;

--Sales by product category
SELECT
	product_category,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM
	beverage_sales
GROUP BY
	product_category
ORDER BY
	total_sales DESC;

--Average transaction value
SELECT
	ROUND(AVG(transaction_qty * unit_price),2) AS avg_transaction_value
FROM
	beverage_sales;

--How do sales vary by day of the week?

SELECT 
    DATENAME(WEEKDAY, transaction_date) AS day_of_week, 
    ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM 
    beverage_sales
GROUP BY 
    DATENAME(WEEKDAY, transaction_date)
ORDER BY 
    CASE DATENAME(WEEKDAY, transaction_date)
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END;

--Sales distribution by hour of the day

SELECT 
    DATEPART(HOUR, transaction_time) AS hour_of_day,
    ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM 
    beverage_sales
GROUP BY 
    DATEPART(HOUR, transaction_time)
ORDER BY 
    hour_of_day;

--Product category with the highest average unit price
SELECT TOP 1
	product_category,
	ROUND(AVG(unit_price),2) AS avg_unit_price
FROM
	beverage_sales
GROUP BY
	product_category
ORDER BY
	avg_unit_price DESC;

--How frequently customers buy certain product types
SELECT
	product_type,
	COUNT(transaction_id) AS purchase_frequency
FROM
	beverage_sales
GROUP BY
	product_type
ORDER BY
	purchase_frequency DESC;

--How frequently customers buy certain products
SELECT
	product_type,
	product_detail,
	COUNT(transaction_id) AS purchase_frequency
FROM
	beverage_sales
GROUP BY
	product_type,
	product_detail
ORDER BY
	purchase_frequency DESC;

--How does unit price affect the quantity sold for each product
SELECT
	product_detail,
	ROUND(AVG(unit_price),2) AS unit_price,
	SUM(transaction_qty) AS quantity_sold
FROM
	beverage_sales
GROUP BY
	product_detail
ORDER BY
	quantity_sold DESC;

--Which store offers the widest variety of products
SELECT
	store_location,
	COUNT(DISTINCT product_detail) AS product_variety
FROM
	beverage_sales
GROUP BY
	store_location
ORDER BY
	product_variety DESC;

--The distribution of sales values per transaction
SELECT
	 transaction_id,
	 SUM(transaction_qty * unit_price) AS transaction_value
FROM
	beverage_sales
GROUP BY
	transaction_id
ORDER BY
	transaction_value desc;

--month-over-month sales growth rate
SELECT
	MONTH(transaction_date) AS month,
	ROUND(SUM(transaction_qty * unit_price),2) AS monthly_sales,
	ROUND(LAG(SUM(transaction_qty * unit_price)) OVER (ORDER BY MONTH(transaction_date)),2) AS previous_month_sales,
	ROUND((SUM(transaction_qty * unit_price)-LAG(SUM(transaction_qty * unit_price)) OVER (ORDER BY MONTH(transaction_date)))
	/LAG(SUM(transaction_qty * unit_price)) OVER (ORDER BY MONTH(transaction_date)),2) AS monthly_growth_rate
FROM
	beverage_sales
GROUP BY
	MONTH(transaction_date);

--using CTE
WITH monthly_sales AS (
	SELECT
	MONTH(transaction_date) AS month,
	ROUND(SUM(transaction_qty * unit_price),2) AS monthly_sales,
	ROUND(LAG(SUM(transaction_qty * unit_price)) OVER (ORDER BY MONTH(transaction_date)),2) AS previous_month_sales
FROM
	beverage_sales
GROUP BY
	MONTH(transaction_date)
)
SELECT
	month,
	ROUND((monthly_sales-previous_month_sales)/previous_month_sales,3)*100 AS monthly_growth_rate
FROM
	monthly_sales
ORDER BY
	month;

--How average sales per transaction compare between stores
SELECT
	store_location,
	ROUND(AVG(transaction_qty * unit_price),2) AS avg_transaction_value
FROM
	beverage_sales
GROUP BY
	store_location
ORDER BY
	avg_transaction_value DESC;

--How sales vary by season 
SELECT 
	CASE 
		WHEN MONTH(transaction_date) IN (12, 1, 2) THEN 'Winter'
		WHEN MONTH(transaction_date) IN (3, 4, 5) THEN 'Spring'
		WHEN MONTH(transaction_date) IN (6, 7, 8) THEN 'Summer'
		WHEN MONTH(transaction_date) IN (9, 10, 11) THEN 'Fall'
	END AS season, 
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM
	beverage_sales
GROUP BY
	CASE 
		WHEN MONTH(transaction_date) IN (12, 1, 2) THEN 'Winter'
		WHEN MONTH(transaction_date) IN (3, 4, 5) THEN 'Spring'
		WHEN MONTH(transaction_date) IN (6, 7, 8) THEN 'Summer'
		WHEN MONTH(transaction_date) IN (9, 10, 11) THEN 'Fall'
	END
ORDER BY
	total_sales DESC;

--How the sales distribution look on an hourly basis for each day of the week
SELECT
	DATENAME(WEEKDAY, transaction_date) AS day_of_week,
	DATEPART(HOUR, transaction_time) AS hour_of_day,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM
	beverage_sales
GROUP BY
	DATENAME(WEEKDAY, transaction_date),
	DATEPART(HOUR, transaction_time)
ORDER BY
	CASE DATENAME(WEEKDAY, transaction_date)
        WHEN 'Sunday' THEN 1
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7
    END,
	hour_of_day;

--Average quantity sold per transaction for each product
SELECT
	product_detail,
	ROUND(AVG(transaction_qty),2) AS avg_quantity_sold
FROM
	beverage_sales
GROUP BY
	product_detail
ORDER BY
	avg_quantity_sold;

--Product Popularity by Location
SELECT 
	store_location, 
	product_detail, 
	SUM(transaction_qty) AS quantity_sold
FROM 
	beverage_sales
GROUP BY 
	store_location, 
	product_detail
ORDER BY 
	store_location, 
	quantity_sold DESC
--HAVING
--	SUM(transaction_qty) > 1000;

--Total sales generated by each product type
SELECT
	product_type,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM
	beverage_sales
GROUP BY
	product_type
ORDER BY
	total_sales DESC;

--average sales per day
WITH daily_sales AS (
	SELECT
		transaction_date,
		SUM(transaction_qty * unit_price) AS daily_sales
	FROM
		beverage_sales
	GROUP BY
		transaction_date
)
SELECT
	ROUND(AVG(daily_sales),2) AS avg_daily_sales
FROM
	daily_sales;

--High Performing Stores by Product Category
SELECT
	store_location,
	product_category,
	ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM
	beverage_sales
GROUP BY
	store_location,product_category
ORDER BY
	store_location,total_sales DESC;

