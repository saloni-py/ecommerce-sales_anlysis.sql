create database Ecommerce_sales_anlysis;
use Ecommerce_sales_anlysis;
create table orders (
order_id int,
customer_id int,
prodcut_id int,
amount int,
order_date date
);
INSERT INTO orders VALUES
(1, 101, 1, 500, '2026-01-05'),
(2, 102, 2, 1200, '2026-01-08'),
(3, 101, 1, 800, '2026-02-12'),
(4, 103, 3, 300, '2026-02-20'),
(5, 102, 2, 950, '2026-03-01'),
(6, 101, 2, 400, '2026-03-15'),
(7, 104, 4, 1500, '2026-03-22'),
(8, 103, 1, 250, '2026-04-02'),
(9, 102, 5, 700, '2026-04-10'),
(10, 104, 3, 320, '2026-04-18');
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50)
);
INSERT INTO products
VALUES
(1, 'Notebook', 'Stationery'),
(2, 'Pen', 'Stationery'),
(3, 'Chair', 'Furniture'),
(4, 'Desk Lamp', 'Electronics'),
(5, 'Marker Set', 'Stationery');
CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO customers (customer_id, customer_name, city)
VALUES
(101, 'Rohit', 'Nagpur'),
(102, 'Sneha', 'Pune'),
(103, 'Aftab', 'Mumbai'),
(104, 'Divya', 'Nagpur');

select sum(amount) as total_renvenue from orders;

 with CustomerTotals as(select customer_id,SUM(amount) as total_order_amount from orders group by  customer_id)
select customer_id,total_order_amount from CustomerTotals where total_order_amount > 1000;

select order_date, order_id ,sum(amount) over (partition by order_date) as total_amount from orders;

select *  from products  join orders  on products.product_id = orders.product_id;

select customer_id, COUNT(*) as total_orders from orders group by customer_id;

select month(order_date) as month,SUM(amount) as total_sales from orders group by month(order_date) order by month;

SELECT 
    o.amount,
    p.product_name,
    p.category,
    c.customer_name,
    c.city
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id;

WITH category_revenue AS (SELECT p.category,SUM(amount) AS total_revenue FROM orders orders JOIN products p ON product_id = p.product_id GROUP BY p.category)
SELECT category,total_revenue,RANK() OVER (ORDER BY total_revenue DESC) AS category_rank FROM category_revenue;