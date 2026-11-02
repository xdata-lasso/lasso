-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (30, NULL, 'shipped27', '1000-01-29', NULL);
INSERT INTO "Users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (37, NULL, 'shipped34', '1000-02-05', 36);
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (19, 30, '1000-01-21', 21, 'shipped');
INSERT INTO "Orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (14, 37, '1000-01-23', 23, 'shipped24');
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (30, 'shipped31', 'shipped', 32, 33);
INSERT INTO "Products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (37, 'shipped38', 'shipped', 39, 40);
INSERT INTO "OrderItems" ("order_item_id", "product_id", "order_id", "quantity", "unit_price") VALUES (30, 30, 14, 30, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name FROM Users AS u JOIN Orders AS o ON u.user_id = o.user_id WHERE o.status = 'shipped';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT u.name FROM Users AS u JOIN Products AS p ON u.user_id = p.product_id WHERE p.category = 'shipped';

/*
Prediction Result:
(None,)
(None,)
*/