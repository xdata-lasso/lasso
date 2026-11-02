-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1026, 'Amber Perez', 'prove', 'James', 1027.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1028, 'Dr. Sharon James', 'figure', 'James', 1028.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarter" FROM "manufacturers" WHERE ("founder" = 'James') ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('figure',)
('prove',)
*/

-- Prediction Query
SELECT headquarter FROM manufacturers WHERE founder = 'James';

/*
Prediction Result:
('prove',)
('figure',)
*/