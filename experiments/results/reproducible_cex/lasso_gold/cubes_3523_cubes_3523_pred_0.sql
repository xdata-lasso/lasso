-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1018, 'Melissa Peterson', 'clearly', 'dinner', 1019.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1024, 'Melissa Peterson', 'clearly', 'dinner', 1019.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1026, 'Monica Herrera', 'win', 'human', 1027.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1032, 'Monica Herrera', 'win', 'human', 1027.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1020, 1018, 'Gabrielle Davis', 1021.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1022, 1018, 'Ryan Munoz', 1023.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1025, 1018, 'Ryan Munoz', 1023.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1028, 1026, 'Edward Fuller', NULL);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1030, 1026, 'Heidi Lee', NULL);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1033, 1026, 'Heidi Lee', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM (SELECT LHS.price AS price, RHS.code AS code, RHS.name AS name, RHS.manufacturer AS manufacturer FROM (SELECT MIN(price) AS price FROM products) AS LHS LEFT JOIN products AS RHS ON (LHS.price = RHS.price)) ORDER BY name, price NULLS LAST;

/*
Gold Result:
('Gabrielle Davis', 1021.5)
*/

-- Prediction Query
SELECT name, price FROM Products ORDER BY price ASC, Products.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Edward Fuller', None)
*/