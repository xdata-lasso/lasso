-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (6, NULL, '9', '9', 142);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (5, '12', '9', '9', -719);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (8, 5, '9', 9);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (7, 5, '9', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, revenue AS max_revenue_, headquarter FROM (SELECT headquarter, name, MAX(revenue) AS revenue FROM manufacturers GROUP BY headquarter, name) ORDER BY name, max_revenue_ NULLS LAST, headquarter NULLS LAST;

/*
Gold Result:
(None, 142.0, '9')
('12', -719.0, '9')
*/

-- Prediction Query
SELECT name, MAX(revenue), Headquarter FROM manufacturers GROUP BY Headquarter;

/*
Prediction Result:
(None, 142.0, '9')
*/