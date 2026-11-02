-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_8257fe', 'man_192017', 'man_f2e07d', 582.588439);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483647, 'man_8257fe', 'man_192017', 'man_f2e07d', 680.190136);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (2, 'man_8257fe', NULL, 'man_f2e07d', 487.053947);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarter FROM manufacturers ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
(None,)
('man_192017',)
('man_192017',)
*/

-- Prediction Query
SELECT DISTINCT headquarter FROM manufacturers;

/*
Prediction Result:
('man_192017',)
(None,)
*/