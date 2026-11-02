-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (id, category, price) VALUES (1, 'Books', 10.0);
INSERT INTO Products (id, category, price) VALUES (2, 'Books', 10.0);
INSERT INTO Products (id, category, price) VALUES (3, 'Books', NULL);
INSERT INTO Products (id, category, price) VALUES (4, 'Toys', 15.0);
INSERT INTO Products (id, category, price) VALUES (5, 'Toys', 20.0);
INSERT INTO Products (id, category, price) VALUES (6, 'Games', 50.0);
INSERT INTO Products (id, category, price) VALUES (7, 'Games', 60.0);
INSERT INTO Products (id, category, price) VALUES (8, NULL, 5.0);
INSERT INTO Products (id, category, price) VALUES (9, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('Books', 3)
('Games', 2)
('Toys', 2)
(None, 2)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('Books', 9)
*/