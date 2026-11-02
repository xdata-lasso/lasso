-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1014, 'Benjamin Stanley', 'surface', 'animal', 1015.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1016, 'Victoria Wyatt', 'surface', 'bar', 1017.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1018, 'Ryan Munoz', 'participant', 'high', 1019.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, headquarter FROM manufacturers ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('Benjamin Stanley', 'surface')
('Ryan Munoz', 'participant')
('Victoria Wyatt', 'surface')
*/

-- Prediction Query
SELECT name, headquarter FROM manufacturers ORDER BY revenue DESC, manufacturers.code NULLS LAST;

/*
Prediction Result:
('Ryan Munoz', 'participant')
('Victoria Wyatt', 'surface')
('Benjamin Stanley', 'surface')
*/