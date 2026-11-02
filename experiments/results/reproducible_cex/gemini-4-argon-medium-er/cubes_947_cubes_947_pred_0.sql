-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Acme', 'New York', 'John', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "revenue" AS "sum_revenue_" FROM (SELECT "code", "name", "headquarter", "founder", "revenue", SUM("revenue") OVER () AS "sumrevenue" FROM "manufacturers") WHERE ("headquarter" = 'Austin' OR sumrevenue <= revenue) ORDER BY sum_revenue_;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT SUM(revenue) FROM manufacturers WHERE headquarter = 'Austin';

/*
Prediction Result:
(None,)
*/