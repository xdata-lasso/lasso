-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("id", "category", "price") VALUES (5, '7', 7);
INSERT INTO "Products" ("id", "category", "price") VALUES (4, '6', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('6', 1)
('7', 1)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('6', 2)
*/