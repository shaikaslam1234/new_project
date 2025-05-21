create database aslam;
create schema YISU;
use YISU;
select * from DA.sales;

-- 1. Find all orders shipped via 'Economy' mode with a total amount greater than ₹25,000.
select * from DA.sales 
	where ship_mode = 'economy' 
		and total_amount > 2500;

-- Q2: Retrieve all sales data for 'Technology' category in 'Ireland' made after 2020-01-01.
select Order_date, Category, Country from DA.sales 
	having category = 'Technology'
	and Country = 'Ireland'
	and order_date > '2020-01-01';
    
-- Q3 List the top 10 most profitable sales transactions in descending order.
	Select *,(Unit_profit * sold_quantity) as Total_Profit from DA.sales 
		order by Total_Profit desc
		limit 10;
        
 -- Q4: Find all customers whose name starts with 'J' and ends with 'n'. 
	Select Customer_name, Country from DA.sales where Customer_Name like 'j%n';
 
 --  Q5: Retrieve all product names that contain 'Acco' anywhere in the name.
 Select distinct product_name from DA.sales 
	where product_name like '%acco%';
    
-- Q6: Get the top 5 cities with the highest total sales amount.
	Select City, Sum(Total_Amount) as Total_Sales from aslam.sales
     group by city
     order by Total_Sales Desc
     limit 5;
     
-- Q7. Find the total revenue, average unit cost, and total number of orders.
	Select sum(total_Amount) as Total_Revenue, avg(Unit_Cost) As Avg_Unit_Cost, count(Distinct ï»¿Order_ID) as Total_Orders from aslam.sales;  

-- Q8. Get total sales per product category.
	select category, sum(Total_Amount) as Total_Sales from DA.sales 
		group by category 
        order by total_Sales DESC;

-- Q9: Get customers who have placed orders worth more than ₹50,000 (aggregate per customer).
	Select Customer_Name, Sum(Total_Amount) as Total_Expenses from aslam.sales
    group by Customer_Name
    having total_Expenses > 50000;

-- Q10. Find the top 5 customers by sales revenue using DENSE_RANK().   
     WITH customer_revenue AS (
  SELECT
    Customer_Name,
    SUM(Total_Amount) AS Total_Revenue
  FROM DA.sales
  GROUP BY Customer_Name
)
SELECT
  Customer_Name,
  Total_Revenue
FROM (
  SELECT
    Customer_Name,
    Total_Revenue,
    DENSE_RANK() OVER (ORDER BY Total_Revenue DESC) AS revenue_rank
  FROM customer_revenue
) ranked
WHERE revenue_rank <= 5
ORDER BY revenue_rank, Total_Revenue DESC;

Select * from DA.sales;