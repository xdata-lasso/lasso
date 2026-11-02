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
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1, -2147483648, '2024-06-15', 935.695299, 'u7vfe4hria2y');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (3, -2147483648, '2024-06-15', 787.938887, 'dpos');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (2, -2147483648, '2024-06-15', 345.718563, 'klfa9000t');

INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (4, -2147483648, NULL, 165.344793, 'wwqcg');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (-2147483648, 'uzhs', 'rwbbp6luhvd', 179.378884, -841692980);

-- Inserting into table: orderitems --
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483648, 1, -2147483648, 1, 182.319045);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (2, 1, -2147483648, 1, 126.856521);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (3, 1, -2147483648, 1, 327.753528);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483645, 3, -2147483648, 1, 983.124993);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483644, 3, -2147483648, 1, 587.103196);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483643, 1, -2147483648, 1, 191.847248);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483642, 1, -2147483648, NULL, 816.814398);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (4, 4, -2147483648, 247012447, 868.436572);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = i.order_id;

/*
Gold Result:
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', None)
('2024-06-15', 1)
('2024-06-15', 1)
(None, 247012447)
*/

-- Prediction Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = o.order_id;

/*
Prediction Result:
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', None)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 247012447)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', None)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 247012447)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', None)
('2024-06-15', 1)
('2024-06-15', 1)
('2024-06-15', 247012447)
(None, 1)
(None, 1)
(None, 1)
(None, 1)
(None, None)
(None, 1)
(None, 1)
(None, 247012447)
*/