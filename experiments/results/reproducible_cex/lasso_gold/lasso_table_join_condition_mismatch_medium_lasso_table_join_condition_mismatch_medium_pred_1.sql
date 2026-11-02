-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, name TEXT, email TEXT, registration_date DATE, is_active INTEGER);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, user_id INTEGER, order_date DATE, total_amount REAL, status TEXT, FOREIGN KEY (user_id) REFERENCES Users (user_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, name TEXT, category TEXT, price REAL, stock_quantity INTEGER);

CREATE TABLE OrderItems (order_item_id INTEGER PRIMARY KEY, order_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, FOREIGN KEY (product_id) REFERENCES Products (product_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "name", "category", "price", "stock_quantity") VALUES (1011, 'Lance Hoffman', 'sense', 1012.5, 1013);
INSERT INTO "users" ("user_id", "name", "email", "registration_date", "is_active") VALUES (1014, 'Kimberly Robinson', 'lisa02@example.net', '1972-03-03', 1015);
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1016, 1014, '1973-04-04', 1017.5, 'knowledge');
INSERT INTO "orders" ("order_id", "user_id", "order_date", "total_amount", "status") VALUES (1021, 1014, '1973-04-04', 1017.5, 'knowledge');
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (1018, 1016, 1011, 1019, 1020.5);
INSERT INTO "orderitems" ("order_item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (1022, 1021, 1011, 1019, 1020.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = i.order_id;

/*
Gold Result:
('1973-04-04', 1019)
('1973-04-04', 1019)
*/

-- Prediction Query
SELECT o.order_date, i.quantity FROM Orders AS o JOIN OrderItems AS i ON o.order_id = o.order_id;

/*
Prediction Result:
('1973-04-04', 1019)
('1973-04-04', 1019)
('1973-04-04', 1019)
('1973-04-04', 1019)
*/