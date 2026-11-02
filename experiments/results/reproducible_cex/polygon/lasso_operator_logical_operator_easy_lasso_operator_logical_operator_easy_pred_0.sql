-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (8, 'shipped8', 'shipped8', '1000-01-09', 8);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (14, 8, '1000-01-13', 797, 'shipped');
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (15, 8, '1000-01-14', -715, 'shipped');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (9, 'shipped8', 'shipped8', 8, 8);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (11, 9, 15, 8, 8);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (10, 9, 15, 8, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE total_amount > 50 AND status = 'shipped';

/*
Gold Result:
(14,)
*/

-- Prediction Query
SELECT order_id FROM Orders WHERE total_amount > 50 OR status = 'shipped';

/*
Prediction Result:
(14,)
(15,)
*/