-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (6, '9', '9', '9', 9);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (9, '9', '9', '9', 9);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (8, 9, NULL, -145);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (7, 9, NULL, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
(None,)
(None,)
*/