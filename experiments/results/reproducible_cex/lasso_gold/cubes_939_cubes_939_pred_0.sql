-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1020, 'Gina Moore', 'source', 'great', 1021.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1024, 'Dennis Williams', 'machine', 'not', 1025.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1032, 'Dennis Williams', 'finally', 'themselves', 1028.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1022, 1020, 'James Howard', 1023.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1026, 1024, 'Thomas Miller', NULL);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1029, 1024, 'Stacey Ward', 1030.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1031, 1020, 'James Howard', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_t1_price_, name FROM (SELECT code, name, AVG(price) AS meanprice FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY code, name) ORDER BY avg_t1_price_, name NULLS LAST;

/*
Gold Result:
(1023.5, 'Gina Moore')
(1030.5, 'Dennis Williams')
*/

-- Prediction Query
SELECT AVG(T1.price), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(1030.5, 'Dennis Williams')
(1023.5, 'Gina Moore')
*/