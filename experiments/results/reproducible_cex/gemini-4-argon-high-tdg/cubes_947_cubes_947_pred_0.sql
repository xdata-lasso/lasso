-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'TechCorp', 'Austin', 'Alice', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Austin', 'Dallas', 'Austin', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'MicroSys', 'Austin', 'Bob', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'NanoWorks', 'Austin', 'Charlie', 100.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (1, 1, 'Widget A', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (2, 3, 'Widget B', 25.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (3, 3, 'Widget C', 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "revenue" AS "sum_revenue_" FROM (SELECT "code", "name", "headquarter", "founder", "revenue", SUM("revenue") OVER () AS "sumrevenue" FROM "manufacturers") WHERE ("headquarter" = 'Austin' OR sumrevenue <= revenue) ORDER BY sum_revenue_;

/*
Gold Result:
(100.0,)
(100.0,)
(500.0,)
*/

-- Prediction Query
SELECT SUM(revenue) FROM manufacturers WHERE headquarter = 'Austin';

/*
Prediction Result:
(700.0,)
*/