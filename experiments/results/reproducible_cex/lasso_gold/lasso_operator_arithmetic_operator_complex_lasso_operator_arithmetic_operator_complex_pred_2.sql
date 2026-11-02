-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, total_amount REAL, tax_rate REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, discount_rate REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name", "discount_rate") VALUES (1001, 'Allison Hill', 2.0);
INSERT INTO "customers" ("customer_id", "name", "discount_rate") VALUES (1002, 'Noah Rhodes', 2.0);
INSERT INTO "customers" ("customer_id", "name", "discount_rate") VALUES (1003, 'Angie Henderson', 2.0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "total_amount", "tax_rate") VALUES (1004, 1001, '1970-01-01', -1.0, 2);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "total_amount", "tax_rate") VALUES (1005, 1001, '1970-01-02', -1.0, 2);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "total_amount", "tax_rate") VALUES (1006, 1001, '1970-01-03', -1.0, 2);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "total_amount", "tax_rate") VALUES (1007, 1001, '1973-04-04', 1010.5, 2);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "total_amount", "tax_rate") VALUES (1008, 1001, '1973-04-05', 1019.5, 2);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "total_amount", "tax_rate") VALUES (1009, 1001, '1973-04-06', 1028.5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Gold Result:
('Allison Hill', -1.0)
('Allison Hill', -1.0)
('Allison Hill', -1.0)
('Allison Hill', 1010.5)
('Allison Hill', 1019.5)
('Allison Hill', 1028.5)
*/

-- Prediction Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount + 2 FROM Orders WHERE tax_rate = 2);

/*
Prediction Result:
('Allison Hill', 1010.5)
('Allison Hill', 1019.5)
('Allison Hill', 1028.5)
*/