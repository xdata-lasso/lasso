-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering, LIMIT 3 boundary, and ensures order of Name, Code, and Revenue do not coincide.
-- Also tests spurious JOINs with Products (M1 has 0 products, M2 has 2 products, M3 has 1 product).
-- Also tests filtering against AVG(revenue) (Mean is 237.5, so M3=200 is below mean, catching WHERE revenue > meanrevenue).
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (10, 'Zeta', 'NY', 'Alice', 50.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (20, 'Beta', 'CA', 'Bob', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (30, 'Alpha', 'TX', 'Charlie', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (40, 'Omega', 'WA', 'David', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (50, 'Gamma', 'FL', 'Eve', 400.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (60, 'Delta', 'IL', 'Frank', 175.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (1, 50, 'ProdA', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (2, 50, 'ProdB', 20.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (3, 20, 'ProdC', 500.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (4, 10, 'ProdD', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT code, name, headquarter, founder, revenue, AVG(revenue) OVER () AS meanrevenue FROM manufacturers) ORDER BY revenue DESC) LIMIT 3);

/*
Gold Result:
('Alpha',)
('Gamma',)
('Beta',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue > (SELECT AVG(revenue) FROM manufacturers);

/*
Prediction Result:
('Alpha',)
('Gamma',)
*/