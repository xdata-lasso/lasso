-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Alpha', 'NY', 'Alice', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Beta', 'LA', 'Bob', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Gamma', 'TX', 'Charlie', 300.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (1, 1, 'P1', 1.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (2, 1, 'P2', 2.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (3, 1, 'P3', 5.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (4, 2, 'P4', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (5, 2, 'P5', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (6, 2, 'P6', 2.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (7, 3, 'P7', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(price) OVER () AS avg_price_ FROM products WHERE (manufacturer = 2 OR price <= 2.0) ORDER BY avg_price_;

/*
Gold Result:
(5.0,)
*/

-- Prediction Query
SELECT AVG(price) FROM products WHERE Manufacturer = 2;

/*
Prediction Result:
(7.333333333333333,)
*/