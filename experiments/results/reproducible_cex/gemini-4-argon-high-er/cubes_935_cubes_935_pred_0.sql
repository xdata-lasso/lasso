-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'M1', 'Boston', 'James', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'M2', 'Austin', 'James', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarter" FROM "manufacturers" WHERE ("founder" = 'James') ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Austin',)
('Boston',)
*/

-- Prediction Query
SELECT headquarter FROM manufacturers WHERE founder = 'James';

/*
Prediction Result:
('Boston',)
('Austin',)
*/