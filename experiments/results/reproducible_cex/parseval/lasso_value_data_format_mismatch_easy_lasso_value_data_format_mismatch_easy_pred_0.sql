-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (-2147483648, '5k5swwqcgs', '9n8', '2020-06-08', -106629402);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483648, -2147483648, '2023-01-01', 1.0, 'u7');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (2, -2147483648, '2023-01-01', 1.0, 'e4');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (3, -2147483648, '2023-01-01', 1.0, 'ia2yp');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483645, -2147483648, '2024-06-15', 1.0, 'hsrwbbp');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483644, -2147483648, '2023-01-01', NULL, 'hvdltt');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (4, -2147483648, NULL, 182.319045, 'nprmdposii');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_amount FROM Orders WHERE order_date = '2023-01-01';

/*
Gold Result:
(1.0,)
(None,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT total_amount FROM Orders WHERE order_date = '01-01-2023';

/*
Prediction Result:
*/