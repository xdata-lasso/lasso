-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1050, 'Lisa Hernandez', 'sound', 'color', 1051.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1053, 'Fred Smith', 'woman', 'him', 1054.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1056, 'Shawn Arroyo', 'bed', 'sign', 1057.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1052, 1050, 'John Pierce', 180.0);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1055, 1053, 'Shane Henderson', 180.0);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1058, 1056, 'Paula Moreno', 181.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price FROM products WHERE (price >= 180.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
('John Pierce', 180.0)
('Paula Moreno', 181.0)
('Shane Henderson', 180.0)
*/

-- Prediction Query
SELECT name, price FROM products WHERE price >= 180 ORDER BY price DESC, name ASC, products.code NULLS LAST;

/*
Prediction Result:
('Paula Moreno', 181.0)
('John Pierce', 180.0)
('Shane Henderson', 180.0)
*/