-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (1145, 'Matthew Gomez', 'item', 1146.5, 1147);
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (1154, 'Joshua Taylor', 'cover', 1155.5, 1156);
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1148, 'Nicholas Nunez', 'brownjessica@example.org', '1973-11-10', 1149);
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1157, 'David Leblanc', 'jmorton@example.org', '1975-02-12', 1158);
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1150, 1148, '1974-01-11', 1151.5, 'energy');
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1159, 1157, '1976-03-13', 1160.5, 'apply');
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (1152, 1150, 1145, 12, 1153.5);
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (1161, 1159, 1154, 12, 1162.5);
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (1163, 1150, 1145, 12, 1153.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE product_id IN (SELECT product_id FROM OrderItems WHERE quantity > 10);

/*
Gold Result:
('Matthew Gomez',)
('Joshua Taylor',)
*/

-- Prediction Query
SELECT p.name FROM Products AS p JOIN OrderItems AS i ON p.product_id = i.product_id WHERE i.quantity > 10;

/*
Prediction Result:
('Matthew Gomez',)
('Joshua Taylor',)
('Matthew Gomez',)
*/