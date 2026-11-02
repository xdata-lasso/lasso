-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1, 'u_s_fbf124', '5k5swwqcgs', '2021-12-04', 1610062532);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (2, 'u_s_fbf124', 'u7', '2023-09-09', -1865039888);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (3, 'u_s_fbf124', 'hria2ypuzhs', '2023-01-03', 906324270);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (4, '5k5swwqcgs', '9n8', '2020-06-08', -106629402);

INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (5, NULL, '5k5swwqcgs', '2021-12-04', 1610062532);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483648, 1, '2025-04-30', 249.706432, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483647, 2, '2020-05-06', 994.117864, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483646, 2, '2022-08-24', 503.083789, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483645, 2, '2023-08-07', 737.440743, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483644, 2, '2023-10-03', 855.355181, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483643, 2, '2022-01-04', 303.05704, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (2, 1, '2021-05-27', 182.319045, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (3, 1, '2022-04-29', 240.969194, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483640, 1, '2023-01-01', 986.066566, 'o_s_79abe1');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483639, 1, '2020-07-11', 792.223623, 'shipped');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (4, 4, '2021-02-11', 688.4027, NULL);

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (5, 5, '2025-04-30', 249.706432, 'shipped');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name FROM Users AS u JOIN Orders AS o ON u.user_id = o.user_id WHERE o.status = 'shipped';

/*
Gold Result:
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
('u_s_fbf124',)
(None,)
*/

-- Prediction Query
SELECT u.name FROM Users AS u JOIN Products AS p ON u.user_id = p.product_id WHERE p.category = 'shipped';

/*
Prediction Result:
*/