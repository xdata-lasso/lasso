-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1001, 'Allison Hill', 'donaldgarcia@example.net', '1970-01-01', 1002);
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1006, 'Allison Hill', 'donaldgarcia@example.net', '1970-01-01', 1002);
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1003, 1001, '1971-02-02', 1004.5, 'wait');
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1007, NULL, '1971-02-02', 1004.5, 'wait');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, o.order_date FROM Users AS u LEFT JOIN Orders AS o ON u.user_id = o.user_id;

/*
Gold Result:
('Allison Hill', '1971-02-02')
('Allison Hill', None)
*/

-- Prediction Query
SELECT u.name, o.order_date FROM Users AS u INNER JOIN Orders AS o ON u.user_id = o.user_id;

/*
Prediction Result:
('Allison Hill', '1971-02-02')
*/