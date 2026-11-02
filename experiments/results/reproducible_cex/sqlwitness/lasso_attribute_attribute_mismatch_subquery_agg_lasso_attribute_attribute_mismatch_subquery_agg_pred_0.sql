-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category_code TEXT NOT NULL, category_name TEXT NOT NULL);

CREATE TABLE Sales (sale_id INTEGER PRIMARY KEY, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, discount INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES Products (product_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, product_name, category_code, category_name) VALUES (1, 'default2', 'default2', 'default1'), (0, 'default2', 'default1', 'default2'), (2, 'default2', 'default2', 'default2'), (3, 'default1', 'default2', 'default2'), (4, 'default1', 'default2', 'default1'), (5, 'default1', 'default2', 'default2'), (6, 'default2', 'default1', 'default2'), (7, 'default1', 'default1', 'default1'), (8, 'default1', 'default1', 'default1'), (9, 'default2', 'default1', 'default2'), (10, 'default1', 'default2', 'default2'), (11, 'default2', 'default2', 'default2'), (12, 'default2', 'default1', 'default1'), (13, 'default1', 'default2', 'default1'), (14, 'default2', 'default2', 'default1'), (15, 'default1', 'default2', 'default1');
INSERT INTO sales (sale_id, product_id, quantity, discount) VALUES (1, 2, 1, 1), (0, 13, 0, 1), (2, 10, 1, 1), (3, 9, 1, 1), (4, 2, 0, 1), (5, 8, 0, 1), (6, 3, 1, 1), (7, 13, 0, 1), (8, 12, 0, 0), (9, 15, 0, 1), (10, 15, 0, 1), (11, 13, 0, 0), (12, 7, 0, 1), (13, 6, 0, 1), (14, 1, 1, 0), (15, 8, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.product_name, P.category_code FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Gold Result:
('default2', 'default2')
('default1', 'default2')
('default2', 'default1')
('default1', 'default2')
('default2', 'default1')
('default1', 'default2')
('default2', 'default2')
('default1', 'default1')
*/

-- Prediction Query
SELECT P.product_name, P.category_name FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Prediction Result:
('default2', 'default2')
('default1', 'default2')
('default2', 'default2')
('default1', 'default2')
('default2', 'default1')
('default1', 'default1')
('default2', 'default1')
('default1', 'default1')
*/