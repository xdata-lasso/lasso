-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Code (ascending vs descending), and ensuring Price is not used as the tie-breaker.
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Acme Corp', 'New York', 'Wile E.', 5000.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (20, 1, 'Widget', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (10, 1, 'Widget', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (5, 1, 'Gadget', 100.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (1, 1, 'Zebra', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Gadget', 100.0)
('Widget', 50.0)
('Widget', 10.0)
('Zebra', 5.0)
*/

-- Prediction Query
SELECT name, price FROM products;

/*
Prediction Result:
('Zebra', 5.0)
('Gadget', 100.0)
('Widget', 50.0)
('Widget', 10.0)
*/