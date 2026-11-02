-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'B', 'HQ1', 'F1', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'A', 'HQ2', 'F2', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, NULL, 'HQ3', 'F3', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, name FROM (SELECT name, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY name) ORDER BY sum_revenue_, name NULLS LAST;

/*
Gold Result:
(100.0, 'A')
(100.0, None)
(200.0, 'B')
*/

-- Prediction Query
SELECT SUM(revenue), name FROM manufacturers GROUP BY name;

/*
Prediction Result:
(100.0, None)
(100.0, 'A')
(200.0, 'B')
*/