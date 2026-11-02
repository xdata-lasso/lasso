-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category_code TEXT NOT NULL, category_name TEXT NOT NULL);

CREATE TABLE Sales (sale_id INTEGER PRIMARY KEY, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, discount INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES Products (product_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (product_id, product_name, category_code, category_name) VALUES (1, 'Widget', 'C1', 'Category 1');
INSERT INTO Sales (sale_id, product_id, quantity, discount) VALUES (1, 1, 10, 0);
INSERT INTO Sales (sale_id, product_id, quantity, discount) VALUES (2, 1, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.product_name, P.category_code FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Gold Result:
('Widget', 'C1')
*/

-- Prediction Query
SELECT P.product_name, P.category_name FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Prediction Result:
('Widget', 'Category 1')
*/