-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1001, 'Allison Hill', 'dog', 'chair', 1002.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1007, 'Allison Hill', 'dog', 'chair', 1002.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1003, 1001, 'Megan Mcclain', 1004.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1005, 1001, 'Megan Mcclain', 1006.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1008, 1001, NULL, 1006.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(None, None, 1006.5)
(1003, 'Megan Mcclain', 1004.5)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(1008, None, 1006.5)
(1003, 'Megan Mcclain', 1004.5)
*/