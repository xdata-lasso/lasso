-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (7, '6', '6', '1000-01-07', 6);
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (6, '6', '6', '1000-01-07', 6);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (6, 6, '1000-01-07', 6, '6');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (9, '6', '6', 6, 6);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (8, '6', '6', 6, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM Users;

/*
Gold Result:
(6, '6', '6', '1000-01-07', 6)
(7, '6', '6', '1000-01-07', 6)
*/

-- Prediction Query
SELECT * FROM Orders;

/*
Prediction Result:
(6, 6, '1000-01-07', 6.0, '6')
*/