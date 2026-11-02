-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (17, 'Electronics', 'Electronics', '9999-12-31', 623942574844584485);
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (16, 'Electronics', 'Electronics', '9999-12-31', 623942574844584485);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (18, 17, '9999-12-31', 623942574844584485, 'Electronics');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (20, 'Electronics21', 'Electronics', -715, NULL);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (19, 'Electronics23', 'Electronics', -714, NULL);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (623942574844584485, 19, 18, 623942574844584485, 623942574844584485);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price > (SELECT MIN(price) FROM Products WHERE category = 'Electronics');

/*
Gold Result:
('Electronics23',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price > (SELECT MAX(price) FROM Products WHERE category = 'Electronics');

/*
Prediction Result:
*/