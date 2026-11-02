-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'A', 'HQ1', 'F1', 20.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'B', 'HQ2', 'F2', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, name FROM (SELECT name, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY name) ORDER BY sum_revenue_, name NULLS LAST;

/*
Gold Result:
(10.0, 'B')
(20.0, 'A')
*/

-- Prediction Query
SELECT SUM(revenue), name FROM manufacturers GROUP BY name;

/*
Prediction Result:
(20.0, 'A')
(10.0, 'B')
*/