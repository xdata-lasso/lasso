-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("id", "category", "price") VALUES (-2147483648, 'pro_143fe4', 582.588439);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483647, 'pro_143fe4', 680.190136);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483646, 'pro_143fe4', 487.053947);

INSERT INTO "products" ("id", "category", "price") VALUES (2, 'pro_143fe4', 486.033807);

INSERT INTO "products" ("id", "category", "price") VALUES (3, 'pro_143fe4', 345.329712);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483645, 'pro_143fe4', 833.684115);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483642, 'pro_143fe4', 261.897639);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483641, 'pro_143fe4', 97.952323);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483640, 'pro_143fe4', 171.746906);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483639, NULL, 557.512061);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483638, NULL, 868.436572);

INSERT INTO "products" ("id", "category", "price") VALUES (-2147483637, NULL, 537.136345);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('pro_143fe4', 9)
(None, 3)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('pro_143fe4', 12)
*/