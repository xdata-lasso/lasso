-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY Founder, SUM(Revenue) vs AVG/MIN/MAX/COUNT, and SUM(DISTINCT Revenue)
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Alpha Corp', 'New York', 'Alice', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Alpha Tech', 'Boston', 'Alice', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Beta Inc', 'Chicago', 'Bob', 150.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'Gamma LLC', 'Seattle', 'Charlie', 50.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'Gamma Soft', 'Austin', 'Charlie', 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrevenue AS sum_revenue_, founder FROM (SELECT founder, SUM(revenue) AS sumrevenue FROM manufacturers GROUP BY founder) ORDER BY sum_revenue_, founder NULLS LAST;

/*
Gold Result:
(150.0, 'Bob')
(200.0, 'Alice')
(300.0, 'Charlie')
*/

-- Prediction Query
SELECT SUM(revenue), founder FROM manufacturers GROUP BY founder;

/*
Prediction Result:
(200.0, 'Alice')
(150.0, 'Bob')
(300.0, 'Charlie')
*/