-- Active: 1743956117730@@127.0.0.1@5432@bookstore_db
-- Create Database Book Store
CREATE DATABASE bookstore_db;

-- Switch to the new database
-- \c bookstore_db

-- Table Creation

-- 1. Books Table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price NUMERIC(6,2) CHECK (price >= 0),
    stock INT,
    published_year INT
);

-- 2. Customers Table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    joined_date DATE DEFAULT CURRENT_DATE
);

-- 3. Orders Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    book_id INT REFERENCES books(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data Insertion

-- books
INSERT INTO books (id, title, author, price, stock, published_year) VALUES
(1, 'The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
(2, 'Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
(3, 'You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
(4, 'Refactoring', 'Martin Fowler', 50.00, 3, 1999),
(5, 'Database Design Principles', 'Jane Smith', 20.00, 0, 2018);

-- customers
INSERT INTO customers (id, name, email, joined_date) VALUES
(3, 'Charlie', 'charlie@email.com', '2023-06-20');

-- orders
INSERT INTO orders (id, customer_id, book_id, quantity, order_date) VALUES
(1, 1, 2, 1, '2024-03-10'),
(2, 2, 1, 1, '2024-02-20'),
(3, 1, 3, 2, '2024-03-05');

-- Queries & Problems

-- 1. Find books that are out of stock
SELECT title
FROM books
WHERE stock = 0;

-- 2. Retrieve the most expensive book
SELECT *
FROM books
WHERE price = (SELECT MAX(price) FROM books);

-- 3. Total number of orders placed by each customer
SELECT c.name, COUNT(o.id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;

-- 4. Calculate total revenue 
SELECT SUM(b.price * o.quantity) AS total_revenue
FROM orders o
JOIN books b ON o.book_id = b.id;

-- 5. Customers who placed more than one order
SELECT c.name, COUNT(o.id) AS orders_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.id) > 1;

-- 6. Average price of books
SELECT ROUND(AVG(price), 2) AS avg_book_price
FROM books;

-- 7. Increase price by 10% for books published before 2000
UPDATE books
SET price = ROUND(price * 1.10, 2)
WHERE published_year < 2000;

-- 8. Delete customers who haven't placed any orders
DELETE FROM customers
WHERE id NOT IN (
    SELECT DISTINCT customer_id FROM orders
);