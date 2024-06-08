-- Retrieve the total number of pizza placed.

select count(order_id) as total_orders from orders;

 -- Calculate the total revenue generated from pizza sales.
 
 select sum(orders_details.quantity * pizzas.price) as total_sales from orders_details join pizzas on orders_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.

SELECT  pizza_types.name, pizzas.price
FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC 
LIMIT 1;

-- Identify the most common pizza size ordered.

SELECT pizzas.size,
COUNT(orders_details.order_details_id) AS order_count FROM pizzas JOIN orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size ORDER BY order_count DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name, sum(orders_details.quantity) as quantity from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details 
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by quantity desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category, sum(orders_details.quantity) as total_quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by total_quantity desc;

-- Determine the distribution of orders by hour of the day.

SELECT HOUR(order_time) AS Hour, COUNT(order_id) as count
FROM orders GROUP BY Hour;

-- find the category-wise distribution of pizzas.

SELECT category, COUNT(name) AS name
FROM pizza_types GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity), 0) AS averagepizzas
FROM (SELECT orders.order_date AS date, SUM(orders_details.quantity) AS quantity
FROM orders
JOIN orders_details ON orders.order_id = orders_details.order_id
GROUP BY date) AS order_quantity;
