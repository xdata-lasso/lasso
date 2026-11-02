-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1, 'use_7fb274', '5k5swwqcgs', '2021-12-04', 1610062532);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (2, 'use_7fb274', 'pgu7vfe4', '2021-05-05', -992890117);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (3, 'use_7fb274', 'a2ypuzhsrwbb', '2022-08-24', 13244799);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (4, NULL, 'hvdltt', '2021-05-27', -1364429300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Users WHERE NOT user_id IN (SELECT user_id FROM Orders);

/*
Gold Result:
('use_7fb274',)
('use_7fb274',)
('use_7fb274',)
(None,)
*/

-- Prediction Query
SELECT user_id FROM Orders;

/*
Prediction Result:
*/