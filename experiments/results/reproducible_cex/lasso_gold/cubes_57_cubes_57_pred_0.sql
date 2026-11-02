-- Schema DDL
CREATE TABLE "038_1" ("Date" REAL, "Sold" INTEGER);

CREATE TABLE "038_2" ("Date" REAL, "Tapped" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "038_1" ("date", "sold") VALUES (1035.5, 1036);
INSERT INTO "038_2" ("date", "tapped") VALUES (1035.5, 1037);
INSERT INTO "038_2" ("date", "tapped") VALUES (1025.5, 1037);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, tapped, sold FROM (SELECT LHS.date AS date, LHS.tapped AS tapped, RHS.sold AS sold FROM "038_2" AS LHS LEFT JOIN "038_1" AS RHS ON (LHS.date = RHS.date)) ORDER BY date, tapped NULLS LAST, sold NULLS LAST;

/*
Gold Result:
(1025.5, 1037, None)
(1035.5, 1037, 1036)
*/

-- Prediction Query
SELECT t2.Date, t2.Tapped, t1.sold AS sold FROM "038_2" AS t2 LEFT JOIN "038_1" AS t1 ON t1.Date = t2.Date;

/*
Prediction Result:
(1035.5, 1037, 1036)
(1025.5, 1037, None)
*/