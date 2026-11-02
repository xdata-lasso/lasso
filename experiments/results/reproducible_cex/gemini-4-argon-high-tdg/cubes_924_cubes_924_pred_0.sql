-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'TechCorp', 'New York', 'Andy', 1000.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'NanoSystems', 'New York', 'Andy', 2000.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'MicroWorks', 'New York', 'Andy', 1500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'MetroLabs', 'New York', 'Bob', 3000.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'PacificGear', 'Los Angeles', 'Andy', 1200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (6, 'BayLogic', 'San Francisco', 'Andy', 1800.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (7, 'LoneStar', 'Austin', 'Charlie', 2500.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'Drive', 150.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 1, 'Monitor', 300.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (103, 4, 'Keyboard', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (104, 7, 'Mouse', 25.0);
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
(5,)
*/