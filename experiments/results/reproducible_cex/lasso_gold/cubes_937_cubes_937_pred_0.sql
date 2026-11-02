-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1026, 'Sony', 'save', 'grow', 1027.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1028, 'Sony', 'sure', 'collection', 1028.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founder" FROM "manufacturers" WHERE ("name" = 'Sony') ORDER BY founder, manufacturers.code NULLS LAST;

/*
Gold Result:
('collection',)
('grow',)
*/

-- Prediction Query
SELECT founder FROM manufacturers WHERE name = 'Sony';

/*
Prediction Result:
('grow',)
('collection',)
*/