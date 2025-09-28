-- 1. SELECT with WHERE and ORDER BY
SELECT name, email
FROM Customers
WHERE country = 'USA'
ORDER BY name ASC;

-- 2. GROUP BY with SUM
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;

-- 3. INNER JOIN to get product details in orders
SELECT o.order_id, p.name AS product_name, od.quantity
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

-- 4. LEFT JOIN to show all customers and their orders (if any)
SELECT c.name, o.order_id, o.total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- 5. Subquery: Customers who spent more than average
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount)
        FROM Orders
    )
);

-- 6. Create a View: Total sales per product
CREATE VIEW ProductSales AS
SELECT p.product_id, p.name, SUM(od.quantity * p.price) AS total_sales
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.name;

-- Optional: Query the view
SELECT * FROM ProductSales;

-- 7. Create Index to optimize customer lookup in Orders
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
