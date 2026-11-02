-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (-2147483648, '5k5swwqcgs', '9n8', '2020-06-08', -106629402);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483648, -2147483648, '2021-02-11', 688.4027, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483647, -2147483648, '2020-12-20', NULL, 'ord_45fb49');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483646, -2147483648, '2025-06-04', NULL, 'ord_a8acb1');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483645, -2147483648, '2023-01-06', NULL, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483644, -2147483648, '2020-01-20', NULL, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483643, -2147483648, '2024-03-30', NULL, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483642, -2147483648, '2023-08-23', NULL, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (2, -2147483648, '2021-03-30', 1.0, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (3, -2147483648, '2023-01-03', 1.0, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (4, -2147483648, '2020-05-06', 994.117864, NULL);

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (5, -2147483648, '2025-08-22', 185.86457, 'shipped');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(total_amount) FROM Orders WHERE status = 'shipped';

/*
Gold Result:
(876.2672699999999,)
*/

-- Prediction Query
SELECT AVG(price) FROM Products;

/*
Prediction Result:
(None,)
*/