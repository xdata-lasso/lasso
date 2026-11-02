-- Schema DDL
CREATE TABLE "031_1" ("channelID" INTEGER, "accountID" TEXT, "role" INTEGER);

CREATE TABLE "031_2" ("channelID" INTEGER, "channelName" TEXT, "type" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "031_2" ("channelID", "channelName", "type") VALUES (20, 'Zeta', 'public');
INSERT INTO "031_2" ("channelID", "channelName", "type") VALUES (10, 'Alpha', 'public');
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (20, 'Dave', 1);
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (10, 'Dave', NULL);
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (10, 'Dave', 5);
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (10, 'Dave', 2);
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (10, 'Dave', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "channelid" AS "c1", "accountid" AS "c2", "role" AS "c3" FROM (SELECT "LHS"."channelid" AS "channelid", "LHS"."accountid" AS "accountid", "LHS"."role" AS "role", "RHS"."channelname" AS "channelname", "RHS"."type" AS "type" FROM "031_1" AS "LHS" INNER JOIN "031_2" AS "RHS" ON ("LHS"."channelid" = "RHS"."channelid")) WHERE ("type" = 'public' AND "accountid" = 'Dave') ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(10, 'Dave', 2)
(10, 'Dave', 2)
(10, 'Dave', 5)
(10, 'Dave', None)
(20, 'Dave', 1)
*/

-- Prediction Query
SELECT '031_2'.channelID, accountID, role FROM "031_2" JOIN "031_1" ON '031_2'.channelID = '031_1'.channelID WHERE AccountID = 'Dave' AND type = 'public';

/*
Prediction Result:
(20, 'Dave', 1)
(10, 'Dave', None)
(10, 'Dave', 2)
(10, 'Dave', 2)
(10, 'Dave', 5)
*/