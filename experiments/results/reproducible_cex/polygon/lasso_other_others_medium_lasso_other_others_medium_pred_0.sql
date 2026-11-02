-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (9, 'shipped7', 'shipped7', '1000-01-08', 7);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (8, 9, '1000-01-08', 7, 'shipped14');
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (7, 9, '1000-01-16', -715, 'shipped');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (10, 'shipped7', 'shipped7', 2790, 7);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (13, 10, 7, 7, 7);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (12, 10, 7, 7, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(total_amount) FROM Orders WHERE status = 'shipped';

/*
Gold Result:
(-715.0,)
*/

-- Prediction Query
SELECT AVG(price) FROM Products;

/*
Prediction Result:
(2790.0,)
*/