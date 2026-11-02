-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1027, 'Tokyo', 'drive', 'spring', 1028.5);
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