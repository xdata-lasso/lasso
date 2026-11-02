-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1010, 'Kimberly Robinson', 'perform', 'fall', 1011.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1014, 'Gina Moore', 'source', 'great', 1015.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1012, 1010, 'Dennis Williams', 1013.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1016, 1014, 'Abigail Shaffer', 1014.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('Abigail Shaffer', 1014.5)
('Dennis Williams', 1013.5)
*/

-- Prediction Query
SELECT name, price FROM products;

/*
Prediction Result:
('Dennis Williams', 1013.5)
('Abigail Shaffer', 1014.5)
*/