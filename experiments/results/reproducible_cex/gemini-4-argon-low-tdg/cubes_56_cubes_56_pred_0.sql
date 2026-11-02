-- Schema DDL
CREATE TABLE "003_1" ("ID" INTEGER, "item" TEXT);

CREATE TABLE "003_2" ("f1" TEXT, "f2" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests: Ambiguous "item" resolution in ORDER BY (sorting by LHS.item vs alias f1 AS item), and NULLS LAST behavior on the second sort key.
INSERT INTO "003_1" ("ID", "item") VALUES (1, 'z_key');
INSERT INTO "003_1" ("ID", "item") VALUES (1, 'a_key');
INSERT INTO "003_1" ("ID", "item") VALUES (1, 'm_key');
INSERT INTO "003_2" ("f1", "f2") VALUES ('b_val', 'z_key');
INSERT INTO "003_2" ("f1", "f2") VALUES ('y_val', 'a_key');
INSERT INTO "003_2" ("f1", "f2") VALUES (NULL, 'm_key');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, f1 AS item FROM (SELECT LHS.id AS id, LHS.item AS item, RHS.f1 AS f1 FROM "003_1" AS LHS INNER JOIN "003_2" AS RHS ON (LHS.item = RHS.f2)) ORDER BY id, item NULLS LAST;

/*
Gold Result:
(1, 'b_val')
(1, 'y_val')
(1, None)
*/

-- Prediction Query
SELECT a.id, b.f1 FROM "003_1" AS a JOIN "003_2" AS b ON b.f2 = a.item ORDER BY a.id, a.item NULLS LAST, b.f1 NULLS LAST, b.f2 NULLS LAST;

/*
Prediction Result:
(1, 'y_val')
(1, None)
(1, 'b_val')
*/