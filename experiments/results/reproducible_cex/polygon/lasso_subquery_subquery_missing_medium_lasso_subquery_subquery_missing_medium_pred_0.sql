-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (13, '25', '25', '1000-01-26', 25);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (26, 13, '1000-01-26', 25, '25');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (14, '25', '25', 25, 25);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (25, NULL, '21', 22, 23);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (19, 25, 26, 797, 20);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (24, 25, 26, 11, 27);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT p.name FROM Products AS p JOIN OrderItems AS i ON p.product_id = i.product_id WHERE i.quantity > 10;

/*
Prediction Result:
(None,)
(None,)
*/