-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483648, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 582.588439);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 680.190136);

-- Inserting into table: products --
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483648, -2147483648, 'pro_b2b6eb', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1, 1, 'rhs_ed7483', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483646, 1, 'pro_b2b6eb', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483645, -2147483648, 'pro_b2b6eb', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483644, 1, NULL, 285.529132);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483643, 1, NULL, 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483642, 1, NULL, 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483641, -2147483648, 'pro_b2b6eb', 97.952323);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483640, -2147483648, 'pro_b2b6eb', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483639, -2147483648, 'pro_b2b6eb', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM (SELECT LHS.price AS price, RHS.code AS code, RHS.name AS name, RHS.manufacturer AS manufacturer FROM (SELECT MIN(price) AS price FROM products) AS LHS LEFT JOIN products AS RHS ON (LHS.price = RHS.price)) ORDER BY name, price NULLS LAST;

/*
Gold Result:
(None, 1.0)
(None, 1.0)
('pro_b2b6eb', 1.0)
('pro_b2b6eb', 1.0)
('pro_b2b6eb', 1.0)
('pro_b2b6eb', 1.0)
('pro_b2b6eb', 1.0)
('rhs_ed7483', 1.0)
*/

-- Prediction Query
SELECT name, price FROM Products ORDER BY price ASC, Products.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('pro_b2b6eb', 1.0)
*/