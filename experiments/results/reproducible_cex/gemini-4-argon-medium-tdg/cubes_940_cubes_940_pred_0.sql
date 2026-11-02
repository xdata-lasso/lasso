-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Acme', 'NY', 'John', 100.5);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Acme', 'LA', 'Jane', 100.5);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Beta', 'TX', 'Bob', 50.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'Gamma', 'FL', 'Alice', 300.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'Delta', 'WA', 'Eve', 0.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (6, 'Epsilon', 'OR', 'Charlie', -20.5);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'Widget A', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 1, 'Widget B', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, name FROM (SELECT name, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY name) ORDER BY sum_revenue_, name NULLS LAST;

/*
Gold Result:
(-20.5, 'Epsilon')
(0.0, 'Delta')
(50.0, 'Beta')
(201.0, 'Acme')
(300.0, 'Gamma')
*/

-- Prediction Query
SELECT SUM(revenue), name FROM manufacturers GROUP BY name;

/*
Prediction Result:
(201.0, 'Acme')
(50.0, 'Beta')
(0.0, 'Delta')
(-20.5, 'Epsilon')
(300.0, 'Gamma')
*/