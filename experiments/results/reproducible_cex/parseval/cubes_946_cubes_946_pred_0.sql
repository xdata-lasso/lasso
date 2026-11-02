-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_6258ed', 'man_723ac8', 'man_f2e07d', 100.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (3, 'man_6258ed', 'man_723ac8', 'man_f2e07d', 100.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (2, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 150.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (4, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 99.99);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (5, 'man_8257fe', 'man_723ac8', 'man_f2e07d', NULL);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (6, 'man_8257fe', 'man_723ac8', 'man_f2e07d', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manufacturers WHERE (revenue >= 100.0 AND revenue < 150.0) ORDER BY name, manufacturers.code NULLS LAST;

/*
Gold Result:
('man_6258ed',)
('man_6258ed',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue BETWEEN 100 AND 150;

/*
Prediction Result:
('man_6258ed',)
('man_8257fe',)
('man_6258ed',)
*/