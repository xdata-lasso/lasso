-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (id, category, price) VALUES (1, 'Books', 10.0);
INSERT INTO Products (id, category, price) VALUES (2, 'Books', 15.0);
INSERT INTO Products (id, category, price) VALUES (3, 'Books', NULL);
INSERT INTO Products (id, category, price) VALUES (4, 'Books', 20.0);
INSERT INTO Products (id, category, price) VALUES (5, 'Books', 25.0);
INSERT INTO Products (id, category, price) VALUES (6, 'Electronics', 100.0);
INSERT INTO Products (id, category, price) VALUES (7, 'Electronics', 200.0);
INSERT INTO Products (id, category, price) VALUES (8, 'Electronics', 300.0);
INSERT INTO Products (id, category, price) VALUES (9, 'Toys', 5.0);
INSERT INTO Products (id, category, price) VALUES (10, 'Toys', 10.0);
INSERT INTO Products (id, category, price) VALUES (11, 'Toys', 15.0);
INSERT INTO Products (id, category, price) VALUES (12, NULL, 50.0);
INSERT INTO Products (id, category, price) VALUES (13, NULL, 60.0);
INSERT INTO Products (id, category, price) VALUES (14, NULL, NULL);
INSERT INTO Products (id, category, price) VALUES (15, 'Clothing', 30.0);
INSERT INTO Products (id, category, price) VALUES (16, 'Clothing', 40.0);
INSERT INTO Products (id, category, price) VALUES (17, 'Automotive', 500.0);
INSERT INTO Products (id, category, price) VALUES (18, 'Garden', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('Books', 5)
('Electronics', 3)
('Toys', 3)
(None, 3)
('Clothing', 2)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('Books', 18)
*/