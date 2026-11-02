-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1006, 'Javier Johnson', 'discover', 'early', 1007.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1008, 1006, 'Alyssa Gonzalez', 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price, manufacturer FROM products WHERE (price > 60.0 AND price <= 120.0) ORDER BY code;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM products WHERE price BETWEEN 60 AND 120;

/*
Prediction Result:
(1008, 1006, 'Alyssa Gonzalez', 60.0)
*/