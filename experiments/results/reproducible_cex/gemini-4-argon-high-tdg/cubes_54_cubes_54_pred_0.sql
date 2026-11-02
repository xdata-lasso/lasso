-- Schema DDL
CREATE TABLE "036_1" ("Account" INTEGER, "Sen1" INTEGER, "Sen2" INTEGER);

CREATE TABLE "036_2" ("ID" INTEGER, "Name" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "036_1" ("Account", "Sen1", "Sen2") VALUES (100, 1, 2);
INSERT INTO "036_1" ("Account", "Sen1", "Sen2") VALUES (200, 3, 4);
INSERT INTO "036_2" ("ID", "Name") VALUES (1, 'Alpha');
INSERT INTO "036_2" ("ID", "Name") VALUES (2, 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_other AS account, name FROM (SELECT LHS.account AS account, LHS.sen1 AS sen1, LHS.sen2 AS sen2, RHS.account AS account_other, RHS.sen1 AS sen1_other, RHS.sen2 AS sen2_other, RHS.name AS name FROM "036_1" AS LHS INNER JOIN (SELECT LHS.account AS account, LHS.sen1 AS sen1, LHS.sen2 AS sen2, RHS.id AS id, RHS.name AS name FROM "036_1" AS LHS CROSS JOIN "036_2" AS RHS) AS RHS ON (LHS.sen2 = RHS.id)) ORDER BY account, name NULLS LAST;

/*
Gold Result:
(100, 'Beta')
(200, 'Beta')
*/

-- Prediction Query
SELECT m.Account, k.Name FROM "036_1" AS m JOIN "036_2" AS k ON k.ID = m.Sen1 OR k.ID = m.Sen2;

/*
Prediction Result:
(100, 'Alpha')
(100, 'Beta')
*/