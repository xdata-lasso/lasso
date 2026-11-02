-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_fe0fb3', 'Tokyo', 'man_25d647', 1.0);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483647, 'man_e04fcb', 'Tokyo', 'man_b9d529', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "headquarter") AS "n_distinct" FROM (SELECT * FROM "manufacturers" WHERE ("headquarter" = 'Tokyo' OR "headquarter" = 'Beijing'))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM manufacturers WHERE headquarter = 'Tokyo' OR headquarter = 'Beijing';

/*
Prediction Result:
(2,)
*/