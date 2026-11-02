-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (-2147483648, 'a2y', 'uzhs', '2023-01-03', 906324270);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (-2147483648, -2147483648, '2020-05-06', 994.117864, 'p6luhvdlttil');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (1, 'pro_3fbb18', '5k5swwqcgs', 171.746906, 247012447);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (3, 'pro_3fbb18', '8c4pgu7vfe', 483.665643, -1633151678);

INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (2, '5k5swwqcgs', '9n8', 874.871895, -106629402);

-- Inserting into table: orderitems --
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483648, -2147483648, 1, 11, 22.535764);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483647, -2147483648, 3, 11, 240.969194);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483646, -2147483648, 1, 11, 986.066566);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483645, -2147483648, 1, 11, 792.223623);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483644, -2147483648, 1, 11, 227.766936);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483643, -2147483648, 1, 11, 133.007885);

INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (-2147483642, -2147483648, 3, NULL, 688.4027);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
('pro_3fbb18',)
('pro_3fbb18',)
*/

-- Prediction Query
SELECT name FROM Products WHERE product_id IN (1, 2, 3);

/*
Prediction Result:
('pro_3fbb18',)
('5k5swwqcgs',)
('pro_3fbb18',)
*/