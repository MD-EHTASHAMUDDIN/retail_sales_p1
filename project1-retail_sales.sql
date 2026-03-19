drop table if exists retail_sales;

create table retail_sales
(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(100),
age	int,
category varchar(100),	
quantity int,
price_per_unit float,	
cogs float,
total_sale float
);


select * from retail_sales;


select 
count(*) 
from retail_sales;

/*checking each column whether there is an null is available
or
data cleaning we have done*/

select * 
from retail_sales
where 
   transactions_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   customer_id is null
   or
   gender is null
   or
   category is null
   or
   quantity is null
   or
   price_per_unit is null
   or
   cogs is null
   or
   total_sale is null
;


--- deleting the null values

delete from retail_sales
where 
   transactions_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   customer_id is null
   or
   gender is null
   or
   category is null
   or
   quantity is null
   or
   price_per_unit is null
   or
   cogs is null
   or
   total_sale is null
;

select 
count(*) 
from retail_sales;

-- data exploration

-- total number of sales
select count(*) as total_sales from retail_sales;


-- total number of customer

select count(distinct(customer_id)) as total_customer from retail_sales;

-- category
select count(distinct(category)),category from retail_sales
group by category;


-- from here data analysis will be start

--DATA ANALYSIS AND BUSINESS KEY PROBLEMS & ANSWER

/*
My Analysis & Findings

Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05
Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing and the quantity sold is more than 18 in the month of Nov-2822
Q.3 Write a SQL query to calculate the total sales (total sale) for each category.
Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
*/


--Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05

select * from retail_sales
where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales
where 
category='Clothing' 
and 
quantity >= 4
and 
to_char(sale_date,'yyyy-mm')='2022-11';


-- Q.3 Write a SQL query to calculate the total sales (total sale) for each category.

select category,sum(total_sale) as net_sale,count(*) as total_order
from retail_sales
group by category;

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
round(avg(age),2) as avg_age
from
retail_sales
where
category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail_sales
where
total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(category),category,gender
from
retail_sales
group by category,gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
year,month,avg_monthly_sale
from
(select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_monthly_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by year,month)
as t
where rank=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) as sum_sale
from retail_sales
group by customer_id
order by sum_sale desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,count(distinct(customer_id)) 
from retail_sales
group by category;

select * from retail_sales


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select *,
case
when
extract(hour from sale_time) < 12 then 'Morning'
when
extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales;








