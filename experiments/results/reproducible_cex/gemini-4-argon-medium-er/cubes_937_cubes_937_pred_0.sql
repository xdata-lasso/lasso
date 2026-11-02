-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Sony', 'Tokyo', 'Z', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Sony', 'Tokyo', 'A', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founder" FROM "manufacturers" WHERE ("name" = 'Sony') ORDER BY founder, manufacturers.code NULLS LAST;

/*
Gold Result:
('A',)
('Z',)
*/

-- Prediction Query
SELECT founder FROM manufacturers WHERE name = 'Sony';

/*
Prediction Result:
('Z',)
('A',)
*/