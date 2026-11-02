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
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1, -2147483648, '2021-02-11', 50.01, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (2, -2147483648, '2021-11-08', 50.01, 'ord_efec75');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (3, -2147483648, '2023-03-15', 50.01, NULL);

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (4, -2147483648, '2024-01-05', 50.0, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (5, -2147483648, '2020-06-07', 50.0, 'ord_efec75');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (6, -2147483648, '2023-04-14', 50.0, NULL);

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (7, -2147483648, '2022-04-27', NULL, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (8, -2147483648, '2025-04-30', NULL, 'ord_efec75');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (9, -2147483648, '2021-02-11', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE total_amount > 50 AND status = 'shipped';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT order_id FROM Orders WHERE total_amount > 50 OR status = 'shipped';

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(7,)
*/