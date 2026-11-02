-- Schema DDL
CREATE TABLE "036_1" ("Account" INTEGER, "Sen1" INTEGER, "Sen2" INTEGER);

CREATE TABLE "036_2" ("ID" INTEGER, "Name" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "036_1" ("account", "sen1", "sen2") VALUES (1001, 1002, 1003);
INSERT INTO "036_1" ("account", "sen1", "sen2") VALUES (1004, 1005, 1006);
INSERT INTO "036_2" ("id", "name") VALUES (1003, 'Allison Hill');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_other AS account, name FROM (SELECT LHS.account AS account, LHS.sen1 AS sen1, LHS.sen2 AS sen2, RHS.account AS account_other, RHS.sen1 AS sen1_other, RHS.sen2 AS sen2_other, RHS.name AS name FROM "036_1" AS LHS INNER JOIN (SELECT LHS.account AS account, LHS.sen1 AS sen1, LHS.sen2 AS sen2, RHS.id AS id, RHS.name AS name FROM "036_1" AS LHS CROSS JOIN "036_2" AS RHS) AS RHS ON (LHS.sen2 = RHS.id)) ORDER BY account, name NULLS LAST;

/*
Gold Result:
(1001, 'Allison Hill')
(1004, 'Allison Hill')
*/

-- Prediction Query
SELECT m.Account, k.Name FROM "036_1" AS m JOIN "036_2" AS k ON k.ID = m.Sen1 OR k.ID = m.Sen2;

/*
Prediction Result:
(1001, 'Allison Hill')
*/