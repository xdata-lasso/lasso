-- Schema DDL
CREATE TABLE "038_1" ("Date" REAL, "Sold" INTEGER);

CREATE TABLE "038_2" ("Date" REAL, "Tapped" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY rules: date (NULLS FIRST default), tapped (NULLS LAST), sold (NULLS LAST)
INSERT INTO "038_2" ("Date", "Tapped") VALUES (NULL, 10);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (NULL, NULL);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (10.5, 20);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (10.5, 5);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (10.5, NULL);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (20.0, 30);
INSERT INTO "038_1" ("Date", "Sold") VALUES (NULL, 999);
INSERT INTO "038_1" ("Date", "Sold") VALUES (10.5, 100);
INSERT INTO "038_1" ("Date", "Sold") VALUES (10.5, NULL);
INSERT INTO "038_1" ("Date", "Sold") VALUES (10.5, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, tapped, sold FROM (SELECT LHS.date AS date, LHS.tapped AS tapped, RHS.sold AS sold FROM "038_2" AS LHS LEFT JOIN "038_1" AS RHS ON (LHS.date = RHS.date)) ORDER BY date, tapped NULLS LAST, sold NULLS LAST;

/*
Gold Result:
(None, 10, None)
(None, None, None)
(10.5, 5, 50)
(10.5, 5, 100)
(10.5, 5, None)
(10.5, 20, 50)
(10.5, 20, 100)
(10.5, 20, None)
(10.5, None, 50)
(10.5, None, 100)
(10.5, None, None)
(20.0, 30, None)
*/

-- Prediction Query
SELECT t2.Date, t2.Tapped, t1.sold AS sold FROM "038_2" AS t2 LEFT JOIN "038_1" AS t1 ON t1.Date = t2.Date;

/*
Prediction Result:
(None, 10, None)
(None, None, None)
(10.5, 20, None)
(10.5, 20, 50)
(10.5, 20, 100)
(10.5, 5, None)
(10.5, 5, 50)
(10.5, 5, 100)
(10.5, None, None)
(10.5, None, 50)
(10.5, None, 100)
(20.0, 30, None)
*/