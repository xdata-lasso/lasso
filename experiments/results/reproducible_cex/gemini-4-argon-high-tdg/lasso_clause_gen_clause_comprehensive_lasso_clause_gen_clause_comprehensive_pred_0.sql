-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (id, category, price) VALUES (1, 'Electronics', 99.99);
INSERT INTO Products (id, category, price) VALUES (2, 'Electronics', 99.99);
INSERT INTO Products (id, category, price) VALUES (3, 'Electronics', NULL);
INSERT INTO Products (id, category, price) VALUES (4, 'Electronics', 150.00);
INSERT INTO Products (id, category, price) VALUES (5, 'Books', 10.00);
INSERT INTO Products (id, category, price) VALUES (6, 'Books', 20.00);
INSERT INTO Products (id, category, price) VALUES (7, 'Books', NULL);
INSERT INTO Products (id, category, price) VALUES (8, NULL, 5.00);
INSERT INTO Products (id, category, price) VALUES (9, NULL, NULL);
INSERT INTO Products (id, category, price) VALUES (10, 'Clothing', 25.00);
INSERT INTO Products (id, category, price) VALUES (11, 'Clothing', 30.00);
INSERT INTO Products (id, category, price) VALUES (12, 'Toys', 15.00);
INSERT INTO Products (id, category, price) VALUES (13, 'Toys', 15.00);
INSERT INTO Products (id, category, price) VALUES (14, 'Food', 2.50);
INSERT INTO Products (id, category, price) VALUES (15, 'Garden', 40.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('Electronics', 4)
('Books', 3)
('Clothing', 2)
('Toys', 2)
(None, 2)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('Electronics', 15)
*/