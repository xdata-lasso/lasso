-- Schema DDL
CREATE TABLE "003_1" ("ID" INTEGER, "item" TEXT);

CREATE TABLE "003_2" ("f1" TEXT, "f2" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "003_1" ("id", "item") VALUES (1024, 'her');
INSERT INTO "003_1" ("id", "item") VALUES (1024, 'husband');
INSERT INTO "003_2" ("f1", "f2") VALUES ('guy', 'her');
INSERT INTO "003_2" ("f1", "f2") VALUES ('bill', 'husband');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, f1 AS item FROM (SELECT LHS.id AS id, LHS.item AS item, RHS.f1 AS f1 FROM "003_1" AS LHS INNER JOIN "003_2" AS RHS ON (LHS.item = RHS.f2)) ORDER BY id, item NULLS LAST;

/*
Gold Result:
(1024, 'bill')
(1024, 'guy')
*/

-- Prediction Query
SELECT a.id, b.f1 FROM "003_1" AS a JOIN "003_2" AS b ON b.f2 = a.item ORDER BY a.id, a.item NULLS LAST, b.f1 NULLS LAST, b.f2 NULLS LAST;

/*
Prediction Result:
(1024, 'guy')
(1024, 'bill')
*/