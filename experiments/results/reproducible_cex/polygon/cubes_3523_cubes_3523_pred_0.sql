-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (8, '797', '797', '797', 797);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (14, '797', '797', '797', 797);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (9, 14, '12', NULL);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (13, 14, '15', 797);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM (SELECT LHS.price AS price, RHS.code AS code, RHS.name AS name, RHS.manufacturer AS manufacturer FROM (SELECT MIN(price) AS price FROM products) AS LHS LEFT JOIN products AS RHS ON (LHS.price = RHS.price)) ORDER BY name, price NULLS LAST;

/*
Gold Result:
('15', 797.0)
*/

-- Prediction Query
SELECT name, price FROM Products ORDER BY price ASC, Products.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('12', None)
*/