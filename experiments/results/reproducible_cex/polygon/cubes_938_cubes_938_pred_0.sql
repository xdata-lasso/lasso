-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (10, NULL, NULL, NULL, NULL);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (9, NULL, NULL, NULL, NULL);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (12, 9, '13', NULL);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (11, NULL, NULL, 8003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(None, '13', None)
(None, None, 8003.0)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(11, None, 8003.0)
(12, '13', None)
*/