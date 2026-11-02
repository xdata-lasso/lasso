-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Code (including negative codes), and ensures rows with 0, 1, or multiple products are handled without unintended joins.
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (10, 'Beta', 'NY', 'Alice', 500.5);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (20, 'Alpha', 'CA', 'Bob', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (5, 'Alpha', 'TX', 'Charlie', 250.75);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (-1, 'Alpha', 'WA', 'Dave', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (100, 10, 'Prod1', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 10, 'Prod2', 20.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 20, 'Prod3', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Alpha', 'WA', 50.0)
('Alpha', 'TX', 250.75)
('Alpha', 'CA', 100.0)
('Beta', 'NY', 500.5)
*/

-- Prediction Query
SELECT name, headquarter, revenue FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Beta', 'NY', 500.5)
('Alpha', 'TX', 250.75)
('Alpha', 'CA', 100.0)
('Alpha', 'WA', 50.0)
*/