-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (1001, 'Allison Hill', 'dog', 1002.5, 1003);
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1004, 'Brian Yang', 'garzaanthony@example.org', '1970-01-01', 1005);
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1006, 1004, '1971-02-02', 1007.5, 'discover');
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (1008, 1006, 1001, 11, 1009.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT name FROM Products WHERE product_id IN (1, 2, 3);

/*
Prediction Result:
*/