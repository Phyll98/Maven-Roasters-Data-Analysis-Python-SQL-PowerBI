# Maven-Roasters-Data-Analysis-Python-SQL-PowerBI
---
![](https://github.com/Phyll98/Maven-Roasters-Data-Analysis-Python-SQL-PowerBI/blob/main/Maven.jpg)
## Introduction

I'm excited to share this data analytics project using the Maven Coffee dataset. This dataset includes 149,116 rows and 11 columns, featuring detailed transaction data.

### Dataset Overview:

 **transaction_id**: Unique sequential ID representing an individual transaction
 
 **transaction_date**: Date of the transaction (MM/DD/YY)
 
 **transaction_time**: Timestamp of the transaction (HH:MM:SS)
 
 **transaction_qty**: Quantity of items sold
 
 **store_id**: Unique ID of the coffee shop where the transaction took place
 
 **store_location**: Location of the coffee shop where the transaction took place
 
 **product_id**: Unique ID of the product sold
 
 **unit_price**: Retail price of the product sold
 
 **product_category**: Description of the product category
 
 **product_type**: Description of the product type
 
 **product_detail**: Description of the product detail
 
---

### Project Process:
- **Data Acquisition:** Downloaded the dataset using Python in Jupyter Notebook.
 
- **Data Cleaning & Transformation:** Data Cleaning and Transformation: Cleaned and transformed the data using SQL in Microsoft SQL Server Management Studio. Tasks included changing data types, checking for outliers, removing null values and duplicates, and Exploratory Data Analysis. 
 
- **Data Analysis & Visualization:** Conducted data modeling, calculated KPIs with DAX formulas, and created an interactive dashboard using Power BI.

  ---

  ## Dashboard1 (Sales Analysis)
  ![](https://github.com/Phyll98/Maven-Roasters-Data-Analysis-Python-SQL-PowerBI/blob/main/Mavenroastersdash1.jpg)
 -  **KPI Cards:** Displays total sales, quantity sold, and number of orders, with monthly comparisons and variances. Includes an area chart to show trends over time. Tracks overall performance and monthly growth or decline.
  
 - **Area Chart:** Shows sales trends by day, week, month, and quarter. Identifies sales patterns and peak periods.
 - **Table:** Breaks down sales by product category, product type, and product detail. Highlights top-performing products and categories.
 - **Donut Chart:** Illustrates sales by store location. Reveals top-performing store locations.

---

## Dashboard2 (Quantity and Orders Analysis)
![](https://github.com/Phyll98/Maven-Roasters-Data-Analysis-Python-SQL-PowerBI/blob/main/Mavenroastersdash2.jpg)
- **KPI Cards:** Shows total quantity sold and orders fulfilled. Provides an overview of sales volume and fulfillment efficiency.
- **Donut Chart:** Displays quantity sold and orders fulfilled by store location. Highlights locations with the highest sales and fulfillment rates.
- **Table:** Breaks down quantity sold and orders fulfilled by product category, product type, and product detail. Identifies best-selling products and order fulfillment by category.
- **Area Chart:** Shows trends in quantity sold and orders fulfilled by day, week, month, and quarter. Uncovers patterns in sales volume and order trends over time.
