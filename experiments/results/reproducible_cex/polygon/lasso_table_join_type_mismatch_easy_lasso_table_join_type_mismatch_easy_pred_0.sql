-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (34, NULL, NULL, NULL, NULL);
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (15, '30', '31', '1000-02-02', 33);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (14, 15, NULL, 25, '26');
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (13, 15, NULL, 28, '29');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (17, '15', '15', 15, 15);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (16, '15', '15', 15, 15);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (19, 16, NULL, 15, 15);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (18, NULL, 13, 15, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, o.order_date FROM Users AS u LEFT JOIN Orders AS o ON u.user_id = o.user_id;

/*
Gold Result:
('30', None)
('30', None)
(None, None)
*/

-- Prediction Query
SELECT u.name, o.order_date FROM Users AS u INNER JOIN Orders AS o ON u.user_id = o.user_id;

/*
Prediction Result:
('30', None)
('30', None)
*/