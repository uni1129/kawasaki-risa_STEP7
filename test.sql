-- 設問１
SELECT
    *
FROM
    `users`;


-- 設問２
SELECT
    *
FROM
    users
WHERE 
    YEAR(created_at) = 2024;


-- 設問３
SELECT
    *
FROM
    users
WHERE
    age < 30 AND gender = 'female';


-- 設問４
SELECT 
  product_name, price 
FROM 
    products;


-- 設問５
SELECT
    users.name, orders.order_date
FROM
    orders
JOIN users ON orders.user_id = users.id;


-- 設問６
SELECT 
    products.product_name,
    order_items.quantity,
    products.price AS unit_price,
    (products.price * order_items.quantity) AS total_amount
FROM 
    order_items
JOIN products ON order_items.product_id = products.id;

-- 設問７
SELECT 
    users.id,
    users.name,
    COUNT(orders.id) AS order_count
FROM 
    users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY 
    users.id, 
    users.name;


-- 設問８
SELECT 
    users.id,
    users.name,
    COALESCE(SUM(products.price * order_items.quantity), 0) AS total_spent
FROM 
    users
LEFT JOIN orders ON users.id = orders.user_id
LEFT JOIN order_items ON orders.id = order_items.order_id
LEFT JOIN products ON order_items.product_id = products.id
GROUP BY
    users.id, 
    users.name;


-- 設問９
SELECT 
    users.name,
    SUM(products.price * order_items.quantity) AS total_spent
FROM 
    users
JOIN orders ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
GROUP BY 
    users.id,
    users.name
ORDER BY 
    total_spent DESC
LIMIT 1;


-- 設問１０
SELECT 
    products.id,
    products.product_name,
    COALESCE(SUM(order_items.quantity), 0) AS total_quantity
FROM 
    products
LEFT JOIN order_items ON products.id = order_items.product_id
GROUP BY 
    products.id, 
    products.product_name;


-- 設問１１
SELECT 
    users.id,
    users.name
FROM 
    users
LEFT JOIN orders ON users.id = orders.user_id
WHERE 
    orders.id IS NULL;


-- 設問１２
SELECT 
    order_id
FROM 
    order_items
GROUP BY 
    order_id
HAVING COUNT(DISTINCT product_id) >= 2;


-- 設問１３
SELECT DISTINCT 
    users.name
FROM 
    users
JOIN orders ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE
    products.product_name = 'テレビ';


-- 設問１４
SELECT 
    orders.order_date,
    users.name AS user_name,
    products.product_name,
    order_items.quantity,
    (products.price * order_items.quantity) AS total_amount
FROM 
    order_items
JOIN orders ON order_items.order_id = orders.id
JOIN users ON orders.user_id = users.id
JOIN products ON order_items.product_id = products.id;


-- 設問１５
SELECT 
    products.product_name,
    SUM(order_items.quantity) AS total_quantity
FROM 
    order_items
JOIN products ON order_items.product_id = products.id
GROUP BY 
    products.id, 
    products.product_name
ORDER BY 
    total_quantity DESC
LIMIT 1;


-- 設問１６
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(id) AS order_count
FROM 
    orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY 
    order_month ASC;


-- 設問１７
SELECT 
    products.id,
    products.product_name
FROM 
    products
LEFT JOIN order_items ON products.id = order_items.product_id
WHERE 
    order_items.id IS NULL;


-- 設問１８
CREATE INDEX idx_order_items_product_id ON order_items(product_id);


-- 設問１９
SELECT 
    users.id,
    users.name,
    COALESCE(AVG(order_totals.total_amount), 0) AS avg_order_amount
FROM 
    users
LEFT JOIN (
    SELECT 
        orders.id AS order_id,
        orders.user_id,
        SUM(products.price * order_items.quantity) AS total_amount
    FROM
        orders
    JOIN order_items ON orders.id = order_items.order_id
    JOIN products ON order_items.product_id = products.id
    GROUP BY 
        orders.id, orders.user_id
) AS order_totals ON users.id = order_totals.user_id
GROUP BY 
    users.id, 
    users.name;


-- 設問２０
SELECT 
    users.id,
    users.name,
    MAX(orders.order_date) AS latest_order_date
FROM 
    users
JOIN orders ON users.id = orders.user_id
GROUP BY
    users.id, 
    users.name;


-- 設問２１
INSERT INTO users (name, age, gender, created_at)
VALUES (7,'中村愛', 25, 'female', '2025-06-01');


-- 設問２２
INSERT INTO products (product_name, price)
VALUES (6,'エアコン', 60000);


-- 設問２３
INSERT INTO orders (id, user_id, order_date)
VALUES (10, 1, '2025-06-10');


-- 設問２４
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (10, 6, 1);


-- 設問２５
UPDATE users
SET 
    age = 24
WHERE 
    name = '田中美咲';


-- 設問２６
UPDATE products
SET
    price = FLOOR(price * 1.10);


-- 設問２７
UPDATE orders
SET
    order_date = '2024-05-01'
WHERE
    order_date < '2024-05-01';


--  設問２８
DELETE 
FROM 
    users
WHERE
    name = '高橋健一';


-- 設問２９
DELETE
FROM
    order_items
WHERE
    order_id = 5;


-- 設問３０
DELETE 
FROM 
    products
WHERE
    id NOT IN (
      SELECT
          DISTINCT product_id 
      FROM 
          order_items
    );