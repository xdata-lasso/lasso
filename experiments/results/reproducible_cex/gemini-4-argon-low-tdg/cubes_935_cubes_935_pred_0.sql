-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'M_Zero', 'Seattle', 'James', 500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'M_One', 'Boston', 'James', 1000.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'M_Multi', 'Austin', 'James', 1500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'M_Other', 'Denver', 'Alice', 2000.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 2, 'Prod_A', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 3, 'Prod_B', 75.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (103, 3, 'Prod_C', 100.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (104, 4, 'Prod_D', 120.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarter" FROM "manufacturers" WHERE ("founder" = 'James') ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Austin',)
('Boston',)
('Seattle',)
*/

-- Prediction Query
SELECT headquarter FROM manufacturers WHERE founder = 'James';

/*
Prediction Result:
('Seattle',)
('Boston',)
('Austin',)
*/