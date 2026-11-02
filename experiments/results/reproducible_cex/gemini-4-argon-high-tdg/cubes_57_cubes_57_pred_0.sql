-- Schema DDL
CREATE TABLE "038_1" ("Date" REAL, "Sold" INTEGER);

CREATE TABLE "038_2" ("Date" REAL, "Tapped" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "038_2" ("Date", "Tapped") VALUES (10.5, 30);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (2.5, 20);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (1.5, 10);
INSERT INTO "038_1" ("Date", "Sold") VALUES (1.5, 100);
INSERT INTO "038_1" ("Date", "Sold") VALUES (3.5, 200);
INSERT INTO "038_1" ("Date", "Sold") VALUES (10.5, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, tapped, sold FROM (SELECT LHS.date AS date, LHS.tapped AS tapped, RHS.sold AS sold FROM "038_2" AS LHS LEFT JOIN "038_1" AS RHS ON (LHS.date = RHS.date)) ORDER BY date, tapped NULLS LAST, sold NULLS LAST;

/*
Gold Result:
(1.5, 10, 100)
(2.5, 20, None)
(10.5, 30, 300)
*/

-- Prediction Query
SELECT t2.Date, t2.Tapped, t1.sold AS sold FROM "038_2" AS t2 LEFT JOIN "038_1" AS t1 ON t1.Date = t2.Date;

/*
Prediction Result:
(10.5, 30, 300)
(2.5, 20, None)
(1.5, 10, 100)
*/