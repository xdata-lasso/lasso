-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1, 'use_1a0568', 'use_47d52d', '2024-06-15', 1);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (2, NULL, '5k5swwqcgs', '2021-12-04', 1610062532);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (3, 'pgu7vfe4', NULL, '2021-05-05', -992890117);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (4, 'a2ypuzhsrwbb', 'p6luhvdlttil', NULL, 429706943);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (5, 'rmdp', 'siie', '2025-06-27', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM Users;

/*
Gold Result:
(1, 'use_1a0568', 'use_47d52d', '2024-06-15', 1)
(2, None, '5k5swwqcgs', '2021-12-04', 1610062532)
(3, 'pgu7vfe4', None, '2021-05-05', -992890117)
(4, 'a2ypuzhsrwbb', 'p6luhvdlttil', None, 429706943)
(5, 'rmdp', 'siie', '2025-06-27', None)
*/

-- Prediction Query
SELECT * FROM Orders;

/*
Prediction Result:
*/