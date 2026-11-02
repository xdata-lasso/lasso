-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (id, category, price) VALUES (1, 'A', 10.0);
INSERT INTO Products (id, category, price) VALUES (2, 'B', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('A', 1)
('B', 1)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('A', 2)
*/