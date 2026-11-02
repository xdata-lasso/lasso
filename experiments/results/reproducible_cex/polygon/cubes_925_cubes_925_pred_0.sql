-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (9, NULL, '121', 121);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (8, NULL, '121', 121);
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
*/