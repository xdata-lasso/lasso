-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Apple', 'Cupertino', 'Jobs', 1000.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Microsoft', 'Redmond', 'Gates', 800.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (1, 1, 'iPhone', 999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("revenue") OVER () AS "sum_revenue_" FROM "manufacturers" WHERE ("headquarter" = 'Tokyo' OR "headquarter" = 'Taiwan') ORDER BY sum_revenue_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(revenue) FROM manufacturers WHERE Headquarter = 'Tokyo' OR Headquarter = 'Taiwan';

/*
Prediction Result:
(None,)
*/