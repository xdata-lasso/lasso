-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(DISTINCT Founder) vs COUNT(Founder), GROUP BY Headquarter, WHERE vs HAVING, and inner JOIN vs no JOIN with Products.
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'M1', 'HQ1', 'Andy', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'M2', 'HQ1', 'Andy', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'M3', 'HQ1', 'Bob', 150.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'M4', 'HQ2', 'Andy', 300.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'M5', 'HQ3', 'Bob', 400.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (6, 'M6', NULL, 'Andy', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'P1', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 1, 'P2', 20.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (103, 5, 'P3', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT "headquarter", COUNT(DISTINCT "founder") AS "n_distinct" FROM (SELECT * FROM "manufacturers" WHERE ("founder" = 'Andy')) GROUP BY headquarter) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM manufacturers WHERE founder = 'Andy';

/*
Prediction Result:
(4,)
*/