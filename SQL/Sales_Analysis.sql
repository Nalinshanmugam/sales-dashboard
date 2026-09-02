show databases;
use supermarket;
select * from sales limit 10;
desc sales;
alter table sales rename  column `Net sales` to Net_Sales;

select sum(net_sales) as Total_Sales ,sum(profit) as Total_profit from Sales;

select Region, sum(net_sales) as Total_Sales from sales
group by Region
order by Total_Sales desc;

select sub_category,sum(net_sales) as Total_sales from sales
group by sub_category
order by Total_sales desc
limit 5;
SET SQL_SAFE_UPDATES = 0;
SELECT Order_Date, STR_TO_DATE(Order_Date, '%d-%b-%Y') AS Converted
FROM sales
LIMIT 5;
SELECT Order_Date FROM sales LIMIT 5;
ALTER TABLE sales ADD COLUMN Order_Date_Fixed DATE;
UPDATE sales SET Order_Date_Fixed = STR_TO_DATE(Order_Date, '%d-%b-%Y');


SELECT DATE_FORMAT(Order_Date_Fixed, '%Y-%m') AS Month, SUM(Net_sales) AS Monthly_Sales
FROM sales
GROUP BY DATE_FORMAT(Order_Date_Fixed, '%Y-%m')
ORDER BY Month;


select sub_category, sum(profit) as Total_profit from sales
group by sub_category
having Total_profit > 0
order by Total_profit desc;

select customer_name,sum(net_sales) as Total_sales from sales
group by customer_name
order by Total_sales desc
limit 10;

SELECT
  DATE_FORMAT(Order_Date_Fixed, '%Y-%m') AS Month,
  SUM(Net_sales) AS Monthly_Sales,
  SUM(SUM(Net_sales)) OVER (ORDER BY DATE_FORMAT(Order_Date_Fixed, '%Y-%m')) AS Running_Total
FROM sales
GROUP BY DATE_FORMAT(Order_Date_Fixed, '%Y-%m')
ORDER BY Month;


desc product_master;
desc customer_master;

select s.order_id,s.product_id,p.supplier,s.net_sales,s.profit 
from sales as s
inner join product_master as p
on s.product_id=p.product_id;

select p.supplier,sum(s.net_sales) as Total_sales 
from sales as s
inner join product_master as p
on s.product_id=p.product_id
group by p.supplier
order by Total_sales desc;


select c.customer_name,c.customer_id
from customer_master as c
left join sales as s
on c.customer_id=s.customer_id
where s.order_id is Null;
