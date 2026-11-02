-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests strict boundary conditions for the price filter (60.0 and 120.0), values just inside/outside the range, and NULL prices.
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 1000.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (1, 1, 'Below Range', 59.99);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (2, 1, 'Exact Lower Boundary', 60.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (3, 1, 'Just Inside Lower Boundary', 60.01);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (4, 1, 'Middle of Range', 90.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (5, 1, 'Just Inside Upper Boundary', 119.99);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (6, 1, 'Exact Upper Boundary', 120.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (7, 1, 'Above Range', 120.01);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (8, 1, 'Null Price', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price, manufacturer FROM products WHERE (price > 60.0 AND price <= 120.0) ORDER BY code;

/*
Gold Result:
(3, 'Just Inside Lower Boundary', 60.01, 1)
(4, 'Middle of Range', 90.0, 1)
(5, 'Just Inside Upper Boundary', 119.99, 1)
(6, 'Exact Upper Boundary', 120.0, 1)
*/

-- Prediction Query
SELECT * FROM products WHERE price BETWEEN 60 AND 120;

/*
Prediction Result:
(2, 1, 'Exact Lower Boundary', 60.0)
(3, 1, 'Just Inside Lower Boundary', 60.01)
(4, 1, 'Middle of Range', 90.0)
(5, 1, 'Just Inside Upper Boundary', 119.99)
(6, 1, 'Exact Upper Boundary', 120.0)
*/