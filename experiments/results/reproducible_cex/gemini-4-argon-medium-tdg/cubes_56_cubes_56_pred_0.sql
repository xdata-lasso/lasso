-- Schema DDL
CREATE TABLE "003_1" ("ID" INTEGER, "item" TEXT);

CREATE TABLE "003_2" ("f1" TEXT, "f2" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests ORDER BY alias resolution: sorting by outer alias `item` (which is RHS.f1) vs inner `LHS.item`, and ASC vs DESC.
INSERT INTO "003_1" ("ID", "item") VALUES (5, 'Z_inner');
INSERT INTO "003_1" ("ID", "item") VALUES (5, 'A_inner');
INSERT INTO "003_1" ("ID", "item") VALUES (3, 'M_inner');
INSERT INTO "003_2" ("f1", "f2") VALUES ('A_outer', 'Z_inner');
INSERT INTO "003_2" ("f1", "f2") VALUES ('Z_outer', 'A_inner');
INSERT INTO "003_2" ("f1", "f2") VALUES ('B_outer', 'M_inner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, f1 AS item FROM (SELECT LHS.id AS id, LHS.item AS item, RHS.f1 AS f1 FROM "003_1" AS LHS INNER JOIN "003_2" AS RHS ON (LHS.item = RHS.f2)) ORDER BY id, item NULLS LAST;

/*
Gold Result:
(3, 'B_outer')
(5, 'A_outer')
(5, 'Z_outer')
*/

-- Prediction Query
SELECT a.id, b.f1 FROM "003_1" AS a JOIN "003_2" AS b ON b.f2 = a.item ORDER BY a.id, a.item NULLS LAST, b.f1 NULLS LAST, b.f2 NULLS LAST;

/*
Prediction Result:
(3, 'B_outer')
(5, 'Z_outer')
(5, 'A_outer')
*/