-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (-2147483648, 'use_198484', '5k5swwqcgs', '2021-12-04', 1);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (2, 'use_198484', '9n8c4pgu7v', '2020-12-20', 1);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (3, 'use_198484', '4h', '2023-01-06', 1);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (-2147483645, 'use_198484', 'a2y', '2022-09-17', 2);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (-2147483644, NULL, 'uzhsrwbbp6lu', '2021-04-10', 1);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (4, 'dlttil', 'n', '2022-09-14', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Users WHERE is_active = 1;

/*
Gold Result:
('use_198484',)
(None,)
('use_198484',)
('use_198484',)
*/

-- Prediction Query
SELECT name FROM Users WHERE is_active = 0;

/*
Prediction Result:
*/