-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (9, 'Electronics', 'Electronics', '9999-12-31', 623942574844584485);
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (8, 'Electronics', 'Electronics', '9999-12-31', 623942574844584485);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (10, 8, '9999-12-31', 623942574844584485, 'Electronics');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (12, 'Electronics15', 'Electronics', -721, 16);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (11, 'Electronics17', 'Electronics', -723, 18);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (14, 11, 10, 623942574844584485, 623942574844584485);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (13, 12, 10, 623942574844584485, 623942574844584485);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(price) FROM Products WHERE category = 'Electronics';

/*
Gold Result:
(-722.0,)
*/

-- Prediction Query
SELECT MIN(price) FROM Products WHERE category = 'Electronics';

/*
Prediction Result:
(-723.0,)
*/