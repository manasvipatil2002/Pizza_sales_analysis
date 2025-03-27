create database pizza_hut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));


create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int  not null,
primary key(order_details_id));




-- 1) How many unique orders exist in the ORDER_DETAILS table.--

SELECT COUNT(DISTINCT order_id) AS unique_orders 
FROM ORDER_DETAILS;


-- 2)  List all pizza types (pizza_id) sold and their quantities.--

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id;

-- 3)  Retrieve the top 5 most frequently ordered pizzas.--

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id 
ORDER BY total_quantity DESC 
LIMIT 5;


-- 4) Retrieve the order_id with the maximum total quantity of pizzas.--

SELECT order_id 
FROM ORDER_DETAILS 
GROUP BY order_id 
ORDER BY SUM(quantity) DESC 
LIMIT 1;


-- 5) Write a query to find the maximum order_details_id in the table.--

SELECT MAX(order_details_id) AS max_order_details_id 
FROM ORDER_DETAILS;



-- 6) How many unique pizza types are there in the ORDER_DETAILS table? --

SELECT COUNT(DISTINCT pizza_id) AS unique_pizzas
 FROM ORDER_DETAILS;


-- 7) Find the quantity of each pizza ordered?--

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id;

-- 8)  What is the average quantity of pizzas ordered per order?--

SELECT AVG(quantity) AS average_quantity 
FROM ORDER_DETAILS;





-- 9) How many pizzas were ordered for each order? --

SELECT o.order_id, COUNT(od.pizza_id) AS total_pizzas 
FROM ORDERS o 
JOIN ORDER_DETAILS od ON o.order_id = od.order_id 
GROUP BY o.order_id;



-- 10) List all orders along with their respective pizza types and quantities? --

SELECT od.order_id, od.pizza_id, od.quantity 
FROM ORDER_DETAILS od;

-- 11) Find the running total of pizzas ordered by order ID.--

SELECT order_id, 
       SUM(quantity) OVER (ORDER BY order_id) AS running_total 
FROM ORDER_DETAILS;




-- 12) Which pizza has the highest quantity ordered?-- 

SELECT pizza_id, SUM(quantity) AS total_quantity 
FROM ORDER_DETAILS 
GROUP BY pizza_id 
ORDER BY total_quantity DESC LIMIT 1;




-- 13) Find all orders that contain more than 2 pizzas using a subquery.--

SELECT order_id 
FROM ORDER_DETAILS 
GROUP BY order_id 
HAVING SUM(quantity) > 2;


-- 14) List all pizzas that have been ordered more than once using a subquery? --

SELECT DISTINCT pizza_id 
FROM ORDER_DETAILS 
WHERE pizza_id IN (SELECT pizza_id FROM ORDER_DETAILS GROUP BY pizza_id HAVING SUM(quantity) > 1);



 -- 15) Classify orders into 'Single', 'Double', and 'Multiple' based on quantity ordered.-- 

 SELECT order_details_id,
       CASE 
           WHEN quantity = 1 THEN 'Single'
           WHEN quantity = 2 THEN 'Double'
           ELSE 'Multiple'
       END AS order_classification
FROM ORDER_DETAILS;




-- 16) Count how many pizzas fall into each classification ('Single', 'Double', 'Multiple'). --

SELECT CASE 
           WHEN quantity = 1 THEN 'Single'
           WHEN quantity = 2 THEN 'Double'
           ELSE 'Multiple'
       END AS classification,
       COUNT(*) AS count
FROM ORDER_DETAILS
GROUP BY classification;


 -- 17) What is the maximum quantity of a single type of pizza ordered? --

SELECT MAX(quantity) AS max_quantity 
FROM ORDER_DETAILS;
