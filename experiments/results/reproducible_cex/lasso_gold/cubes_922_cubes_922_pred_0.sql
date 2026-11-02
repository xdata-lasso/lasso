-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1005, 'Javier Johnson', 'discover', 'early', 1006.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1009, 'Javier Johnson', 'discover', 'early', 1006.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1007, 1005, 'Alyssa Gonzalez', 1008.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1010, 1009, 'Alyssa Gonzalez', 1008.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT manufacturer, name, COUNT(*) AS n FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY manufacturer, name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Javier Johnson')
(1, 'Javier Johnson')
*/

-- Prediction Query
SELECT COUNT(*), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(2, 'Javier Johnson')
*/