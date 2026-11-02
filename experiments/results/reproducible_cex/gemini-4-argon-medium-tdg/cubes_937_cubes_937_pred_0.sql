-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate Founder values (kills SELECT DISTINCT), primary sorting on Founder, and NULL handling in Founder and Code.
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (10, 'Sony', 'Tokyo', 'Masaru Ibuka', 80.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (20, 'Sony', 'Minato', 'Akio Morita', 90.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (30, 'Sony', 'Shinagawa', 'Akio Morita', 85.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (40, 'Sony', 'Konan', NULL, 70.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (NULL, 'Sony', 'Chiyoda', 'Akio Morita', 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founder" FROM "manufacturers" WHERE ("name" = 'Sony') ORDER BY founder, manufacturers.code NULLS LAST;

/*
Gold Result:
(None,)
('Akio Morita',)
('Akio Morita',)
('Akio Morita',)
('Masaru Ibuka',)
*/

-- Prediction Query
SELECT founder FROM manufacturers WHERE name = 'Sony';

/*
Prediction Result:
('Masaru Ibuka',)
('Akio Morita',)
('Akio Morita',)
(None,)
('Akio Morita',)
*/