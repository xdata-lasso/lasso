-- Schema DDL
CREATE TABLE "003_1" ("ID" INTEGER, "item" TEXT);

CREATE TABLE "003_2" ("f1" TEXT, "f2" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "003_1" ("ID", "item") VALUES (2, 'k_two');
INSERT INTO "003_1" ("ID", "item") VALUES (1, '1_m');
INSERT INTO "003_1" ("ID", "item") VALUES (1, '2_m');
INSERT INTO "003_1" ("ID", "item") VALUES (1, '3_m');
INSERT INTO "003_1" ("ID", "item") VALUES (1, '4_m');
INSERT INTO "003_1" ("ID", "item") VALUES (-5, 'k_neg');
INSERT INTO "003_1" ("ID", "item") VALUES (NULL, 'n_1');
INSERT INTO "003_1" ("ID", "item") VALUES (NULL, 'n_2');
INSERT INTO "003_1" ("ID", "item") VALUES (NULL, 'n_3');
INSERT INTO "003_2" ("f1", "f2") VALUES ('Z', 'k_two');
INSERT INTO "003_2" ("f1", "f2") VALUES ('B', '1_m');
INSERT INTO "003_2" ("f1", "f2") VALUES (NULL, '2_m');
INSERT INTO "003_2" ("f1", "f2") VALUES ('C', '3_m');
INSERT INTO "003_2" ("f1", "f2") VALUES ('A', '4_m');
INSERT INTO "003_2" ("f1", "f2") VALUES ('M', 'k_neg');
INSERT INTO "003_2" ("f1", "f2") VALUES ('Y', 'n_1');
INSERT INTO "003_2" ("f1", "f2") VALUES (NULL, 'n_2');
INSERT INTO "003_2" ("f1", "f2") VALUES ('X', 'n_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, f1 AS item FROM (SELECT LHS.id AS id, LHS.item AS item, RHS.f1 AS f1 FROM "003_1" AS LHS INNER JOIN "003_2" AS RHS ON (LHS.item = RHS.f2)) ORDER BY id, item NULLS LAST;

/*
Gold Result:
(None, 'X')
(None, 'Y')
(None, None)
(-5, 'M')
(1, 'A')
(1, 'B')
(1, 'C')
(1, None)
(2, 'Z')
*/

-- Prediction Query
SELECT a.id, b.f1 FROM "003_1" AS a JOIN "003_2" AS b ON b.f2 = a.item ORDER BY a.id, a.item NULLS LAST, b.f1 NULLS LAST, b.f2 NULLS LAST;

/*
Prediction Result:
(None, 'Y')
(None, None)
(None, 'X')
(-5, 'M')
(1, 'B')
(1, None)
(1, 'C')
(1, 'A')
(2, 'Z')
*/