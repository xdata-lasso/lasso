-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (14, NULL, '20', '21', 22);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (13, NULL, NULL, NULL, NULL);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (30, 13, '31', NULL);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (23, 14, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_t1_price_, name FROM (SELECT code, name, AVG(price) AS meanprice FROM (SELECT code, name, headquarter, founder, revenue, code_other, name_other, price, code AS manufacturer FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.headquarter AS headquarter, LHS.founder AS founder, LHS.revenue AS revenue, RHS.code AS code_other, RHS.name AS name_other, RHS.price AS price FROM manufacturers AS LHS INNER JOIN products AS RHS ON (LHS.code = RHS.manufacturer))) GROUP BY code, name) ORDER BY avg_t1_price_, name NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
*/

-- Prediction Query
SELECT AVG(T1.price), T2.name FROM products AS T1 JOIN manufacturers AS T2 ON T1.Manufacturer = T2.code GROUP BY T2.name;

/*
Prediction Result:
(None, None)
*/