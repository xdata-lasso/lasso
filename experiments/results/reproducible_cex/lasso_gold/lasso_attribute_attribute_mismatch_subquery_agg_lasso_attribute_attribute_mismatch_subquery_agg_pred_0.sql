-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category_code TEXT NOT NULL, category_name TEXT NOT NULL);

CREATE TABLE Sales (sale_id INTEGER PRIMARY KEY, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, discount INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES Products (product_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (1001, 'Allison Hill', 'all', 'Lance Hoffman');
INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (1002, 'Noah Rhodes', 'better', 'Meredith Barnes');
INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (1003, 'Angie Henderson', 'discover', 'Donald Booth');
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (1004, 1001, 3, 0);
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (1005, 1001, 1, 0);
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (1006, 1001, -1, 0);
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (1007, 1001, 0, 0);
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (1008, 1001, 0, 0);
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (1009, 1001, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.product_name, P.category_code FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Gold Result:
('Allison Hill', 'all')
('Allison Hill', 'all')
*/

-- Prediction Query
SELECT P.product_name, P.category_name FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Prediction Result:
('Allison Hill', 'Lance Hoffman')
('Allison Hill', 'Lance Hoffman')
*/