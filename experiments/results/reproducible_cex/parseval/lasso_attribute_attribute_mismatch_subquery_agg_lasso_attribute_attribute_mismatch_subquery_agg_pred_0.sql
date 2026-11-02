-- Schema DDL
CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT NOT NULL, category_code TEXT NOT NULL, category_name TEXT NOT NULL);

CREATE TABLE Sales (sale_id INTEGER PRIMARY KEY, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, discount INTEGER NOT NULL, FOREIGN KEY (product_id) REFERENCES Products (product_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (1, 'p_s_3b3722', 'p_s_a3b854', '5k5swwqcgs');

INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (-2147483648, 'p_s_3b3722', 'p_s_a3b854', '9n8');

INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (3, 'p_s_3b3722', 'p_s_a3b854', '4');

INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (2, 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "products" ("product_id", "product_name", "category_code", "category_name") VALUES (4, 'rwbbp6luhvd', 'tti', 'bnp');

-- Inserting into table: sales --
INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483648, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483647, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483646, 2, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483645, 2, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483644, 2, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (2, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (3, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483641, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483640, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483639, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483638, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (-2147483637, 1, 1, 1);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (4, 1, 8855, -2943);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (5, 3, 11797, 0);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (6, 4, 8855, -2943);

INSERT INTO "sales" ("sale_id", "product_id", "quantity", "discount") VALUES (7, -2147483648, 11797, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.product_name, P.category_code FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Gold Result:
('p_s_3b3722', 'p_s_a3b854')
('p_s_3b3722', 'p_s_a3b854')
('rwbbp6luhvd', 'tti')
('p_s_3b3722', 'p_s_a3b854')
*/

-- Prediction Query
SELECT P.product_name, P.category_name FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Prediction Result:
('p_s_3b3722', '5k5swwqcgs')
('p_s_3b3722', '4')
('rwbbp6luhvd', 'bnp')
('p_s_3b3722', '9n8')
*/