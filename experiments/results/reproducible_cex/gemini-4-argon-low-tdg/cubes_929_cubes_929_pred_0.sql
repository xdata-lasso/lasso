-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (DESC vs ASC), LIMIT 3 boundary (>3 rows), and queries that mistakenly filter by meanrevenue (mean is 55, so top 3 includes rows both above and below the mean: 200, 15, 10).
-- Also tests unintended INNER JOIN / EXISTS with Products (some top 3 have products, some have 0, some have multiple).
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Mfg_15', 'HQ_A', 'Founder_X', 15.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Mfg_200', 'HQ_B', 'Founder_Y', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Mfg_5', 'HQ_A', 'Founder_Z', 5.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'Mfg_10', 'HQ_C', 'Founder_W', 10.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'Mfg_45_DeletedOrExcluded', 'HQ_D', 'Founder_V', -5.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 2, 'Prod_A', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 2, 'Prod_B', 60.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (103, 3, 'Prod_C', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT code, name, headquarter, founder, revenue, AVG(revenue) OVER () AS meanrevenue FROM manufacturers) ORDER BY revenue DESC) LIMIT 3);

/*
Gold Result:
('Mfg_200',)
('Mfg_15',)
('Mfg_10',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue > (SELECT AVG(revenue) FROM manufacturers);

/*
Prediction Result:
('Mfg_200',)
*/