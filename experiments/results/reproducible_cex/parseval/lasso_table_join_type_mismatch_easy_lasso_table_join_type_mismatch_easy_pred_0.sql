-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1, 'u_s_fb7da5', '5k5swwqcgs', '2021-12-04', 1610062532);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (3, 'u_s_fb7da5', 'fe4hri', '2020-01-20', 1268590800);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (2, 'u_s_fb7da5', 'ilbnp', '2023-01-01', 2087640001);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (4, NULL, '5k5swwqcgs', '2021-12-04', 1610062532);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483648, 1, '2024-06-15', 475.173408, 'u7');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (2, 1, '2024-06-15', 378.476082, 'uzhs');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (3, 1, '2024-06-15', 663.049759, 'wbbp6luhvdlt');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483645, 3, '2024-06-15', 666.330692, 'p');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483644, 3, '2024-06-15', 227.766936, 'iie5u');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483643, 1, '2024-06-15', 933.422701, '6klfa9');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483642, 1, NULL, 877.276439, '00t5c4ecigc');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (4, 4, '2025-04-30', 249.706432, 'u7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, o.order_date FROM Users AS u LEFT JOIN Orders AS o ON u.user_id = o.user_id;

/*
Gold Result:
('u_s_fb7da5', None)
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', None)
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
(None, '2025-04-30')
*/

-- Prediction Query
SELECT u.name, o.order_date FROM Users AS u INNER JOIN Orders AS o ON u.user_id = o.user_id;

/*
Prediction Result:
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', None)
('u_s_fb7da5', '2024-06-15')
('u_s_fb7da5', '2024-06-15')
(None, '2025-04-30')
*/