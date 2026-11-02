-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (3, 'Henry Santiago', 'science', 'write', 1028.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1029, 3, 'Andrea Reid', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(price) OVER () AS avg_price_ FROM products WHERE (manufacturer = 2 OR price <= 2.0) ORDER BY avg_price_;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(price) FROM products WHERE Manufacturer = 2;

/*
Prediction Result:
(None,)
*/