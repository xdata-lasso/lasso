-- Schema DDL
CREATE TABLE "038_1" ("Date" REAL, "Sold" INTEGER);

CREATE TABLE "038_2" ("Date" REAL, "Tapped" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "038_1" ("Date", "Sold") VALUES (1.0, 200);
INSERT INTO "038_1" ("Date", "Sold") VALUES (1.0, NULL);
INSERT INTO "038_1" ("Date", "Sold") VALUES (1.0, 50);
INSERT INTO "038_1" ("Date", "Sold") VALUES (2.0, 300);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (1.0, 20);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (1.0, NULL);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (1.0, 10);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (NULL, 5);
INSERT INTO "038_2" ("Date", "Tapped") VALUES (3.0, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, tapped, sold FROM (SELECT LHS.date AS date, LHS.tapped AS tapped, RHS.sold AS sold FROM "038_2" AS LHS LEFT JOIN "038_1" AS RHS ON (LHS.date = RHS.date)) ORDER BY date, tapped NULLS LAST, sold NULLS LAST;

/*
Gold Result:
(None, 5, None)
(1.0, 10, 50)
(1.0, 10, 200)
(1.0, 10, None)
(1.0, 20, 50)
(1.0, 20, 200)
(1.0, 20, None)
(1.0, None, 50)
(1.0, None, 200)
(1.0, None, None)
(3.0, 30, None)
*/

-- Prediction Query
SELECT t2.Date, t2.Tapped, t1.sold AS sold FROM "038_2" AS t2 LEFT JOIN "038_1" AS t1 ON t1.Date = t2.Date;

/*
Prediction Result:
(1.0, 20, None)
(1.0, 20, 50)
(1.0, 20, 200)
(1.0, None, None)
(1.0, None, 50)
(1.0, None, 200)
(1.0, 10, None)
(1.0, 10, 50)
(1.0, 10, 200)
(None, 5, None)
(3.0, 30, None)
*/