# PostgreSQL Basics

## 1. What is PostgreSQL?

**PostgreSQL** হলো একটি ওপেন সোর্স রিলেশনাল ডেটাবেইস ম্যানেজমেন্ট সিস্টেম (RDBMS), যেখানে টেবিল আকারে ডেটা সংরক্ষণ ও ব্যবস্থাপনা করা হয়। এটি খুবই শক্তিশালী, নিরাপদ এবং বড় স্কেলেও ভালোভাবে কাজ করে।

---

## 2. What is the purpose of a database schema in PostgreSQL?

**Schema** মানে ডাটাবেইসের ভেতরে একধরনের লজিক্যাল গ্রুপিং যা টেবিল, ফাংশন, ভিউ ইত্যাদি আলাদা করে সাজিয়ে রাখতে সাহায্য করে।  
উদাহরণ: `sales`, `inventory`, `admin` নামে আলাদা স্কিমা থাকতে পারে।

---

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

- **Primary Key**: প্রতিটা রেকর্ডকে ইউনিকভাবে শনাক্ত করে।  
  ```sql
  id SERIAL PRIMARY KEY
  ```

- **Foreign Key**: এক টেবিলের কলাম যা অন্য টেবিলের Primary Key কে রেফার করে।  
  ```sql
  customer_id INT REFERENCES customers(id)
  ```

---

## 4. What is the difference between the VARCHAR and CHAR data types?

| টাইপ    | ব্যাখ্যা |
|--------|---------|
| `VARCHAR(n)` | যতটুকু ডেটা দরকার ততটুকু জায়গা নেয়, লম্বা হলে `n` পর্যন্ত নেয় |
| `CHAR(n)`    | সবসময় `n` ক্যারেক্টার ধরে রাখে, বাকি থাকলে স্পেস দিয়ে পূরণ করে |

---

## 5. Explain the purpose of the WHERE clause in a SELECT statement.

**WHERE** ক্লজ দিয়ে শর্ত দিয়ে ডেটা ফিল্টার করা হয়।

```sql
SELECT * FROM books WHERE price > 40;
```
৪০ টাকার বেশি দামের বইগুলো দেখাবে।

---

## 6. What are the LIMIT and OFFSET clauses used for?

- `LIMIT`: কয়টা রেকর্ড দেখাবে  
- `OFFSET`: কয়টা রেকর্ড স্কিপ করবে

```sql
SELECT * FROM books LIMIT 5 OFFSET 10;
```
১১তম থেকে ৫টা রেকর্ড দেখাবে।

---

## 7. How can you modify data using UPDATE statements?

```sql
UPDATE books SET price = 45 WHERE id = 1;
```
`id = 1` এর বইয়ের দাম ৪৫ করা হলো।

---

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

**JOIN** দিয়ে একাধিক টেবিল থেকে ডেটা একসাথে আনা যায় (রিলেশন অনুযায়ী)।

```sql
SELECT customers.name, books.title
FROM orders
JOIN customers ON orders.customer_id = customers.id
JOIN books ON orders.book_id = books.id;
```
অর্ডারের মাধ্যমে কোন কাস্টমার কোন বই কিনেছে সেটা দেখাবে।

---

## 9. Explain the GROUP BY clause and its role in aggregation operations.

**GROUP BY** দিয়ে নির্দিষ্ট ফিল্ড অনুসারে ডেটা ভাগ করে অ্যাগ্রিগেট ফাংশন চালানো যায়।

```sql
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;
```

---

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

```sql
-- মোট কতগুলো বই আছে
SELECT COUNT(*) FROM books;

-- বইয়ের দামগুলোর যোগফল
SELECT SUM(price) FROM books;

-- গড় দাম
SELECT AVG(price) FROM books;
```
