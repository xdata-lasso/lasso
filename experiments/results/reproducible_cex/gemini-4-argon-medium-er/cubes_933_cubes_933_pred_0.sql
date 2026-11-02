-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'M1', 'HQ1', 'A', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'M2', 'HQ2', 'B', 10.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'M3', 'HQ3', NULL, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, founder FROM (SELECT founder, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY founder) ORDER BY sum_revenue_, founder NULLS LAST;

/*
Gold Result:
(10.0, 'B')
(10.0, None)
(100.0, 'A')
*/

-- Prediction Query
SELECT SUM(revenue), founder FROM manufacturers GROUP BY founder;

/*
Prediction Result:
(10.0, None)
(100.0, 'A')
(10.0, 'B')
*/