-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (7, NULL, '10', '11', 100);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (6, NULL, '12', '13', 150);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (9, 6, '14', 14);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (8, 6, '14', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manufacturers WHERE (revenue >= 100.0 AND revenue < 150.0) ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150;

/*
Prediction Result:
(None,)
(None,)
*/