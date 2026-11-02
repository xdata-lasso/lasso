-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1020, 'Gina Moore', 'source', 'great', 1021.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1024, 'Dennis Williams', 'machine', 'not', 1025.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1022, 1020, 'James Howard', 1023.5);
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1026, 1024, 'Thomas Miller', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanprice AS avg_price_, manufacturer FROM (SELECT manufacturer, AVG(price) AS meanprice FROM products GROUP BY manufacturer) ORDER BY avg_price_, manufacturer NULLS LAST;

/*
Gold Result:
(None, 1024)
(1023.5, 1020)
*/

-- Prediction Query
SELECT AVG(Price), Manufacturer FROM Products GROUP BY Manufacturer;

/*
Prediction Result:
(1023.5, 1020)
(None, 1024)
*/