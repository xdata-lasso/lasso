-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (13, '26', '26', '1000-01-27', 26);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (12, 13, '1000-01-27', NULL, '24');
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (18, NULL, '1000-01-27', NULL, NULL);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (15, '26', '26', 26, 26);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (17, '26', '26', 26, 26);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (16, 17, 18, 29, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = i.order_id;

/*
Gold Result:
('1000-01-27', 29)
*/

-- Prediction Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = o.order_id;

/*
Prediction Result:
('1000-01-27', 29)
('1000-01-27', 29)
*/