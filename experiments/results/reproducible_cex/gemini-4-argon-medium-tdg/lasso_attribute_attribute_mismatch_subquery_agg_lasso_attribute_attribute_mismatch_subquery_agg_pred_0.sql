-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category_code TEXT NOT NULL, category_name TEXT NOT NULL);

CREATE TABLE Sales (sale_id INTEGER PRIMARY KEY, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, discount INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES Products (product_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (> vs >=), arithmetic operator mutations (- vs +), and column projections.
INSERT INTO Products (product_id, product_name, category_code, category_name) VALUES (1, 'Laptop', 'ELEC', 'Electronics');
INSERT INTO Products (product_id, product_name, category_code, category_name) VALUES (2, 'Mouse', 'ACC', 'Accessories');
INSERT INTO Products (product_id, product_name, category_code, category_name) VALUES (3, 'Monitor', 'DISP', 'Displays');
INSERT INTO Sales (sale_id, product_id, quantity, discount) VALUES (101, 1, 10, 8);
INSERT INTO Sales (sale_id, product_id, quantity, discount) VALUES (102, 2, 10, 4);
INSERT INTO Sales (sale_id, product_id, quantity, discount) VALUES (103, 3, 10, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.product_name, P.category_code FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Gold Result:
('Monitor', 'DISP')
*/

-- Prediction Query
SELECT P.product_name, P.category_name FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Prediction Result:
('Monitor', 'Displays')
*/