-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT) vs COUNT(*) or COUNT(Headquarter) by having duplicate 'Tokyo' and 'Beijing' rows.
-- 2. WHERE clause filtering vs unfiltered COUNT by including 'Seoul' and NULL headquarters.
-- 3. Wrong column in COUNT(DISTINCT ...) by having NULLs/duplicates in Name, Founder, Revenue.
-- 4. Unnecessary INNER JOIN with Products by having only 1 product for a single manufacturer.
-- Expected output: 2
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, NULL, 'Tokyo', NULL, NULL);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, NULL, 'Tokyo', NULL, NULL);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, NULL, 'Beijing', NULL, NULL);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, NULL, 'Beijing', NULL, NULL);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'Samsung', 'Seoul', 'Lee', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (6, 'Unknown', NULL, 'Anon', 0.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'Camera', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "headquarter") AS "n_distinct" FROM (SELECT * FROM "manufacturers" WHERE ("headquarter" = 'Tokyo' OR "headquarter" = 'Beijing'))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM manufacturers WHERE headquarter = 'Tokyo' OR headquarter = 'Beijing';

/*
Prediction Result:
(4,)
*/