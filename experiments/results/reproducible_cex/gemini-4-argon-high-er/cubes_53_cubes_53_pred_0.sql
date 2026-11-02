-- Schema DDL
CREATE TABLE "031_1" ("channelID" INTEGER, "accountID" TEXT, "role" INTEGER);

CREATE TABLE "031_2" ("channelID" INTEGER, "channelName" TEXT, "type" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (2, 'Dave', 2);
INSERT INTO "031_1" ("channelID", "accountID", "role") VALUES (1, 'Dave', 1);
INSERT INTO "031_2" ("channelID", "channelName", "type") VALUES (2, 'general', 'public');
INSERT INTO "031_2" ("channelID", "channelName", "type") VALUES (1, 'random', 'public');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "channelid" AS "c1", "accountid" AS "c2", "role" AS "c3" FROM (SELECT "LHS"."channelid" AS "channelid", "LHS"."accountid" AS "accountid", "LHS"."role" AS "role", "RHS"."channelname" AS "channelname", "RHS"."type" AS "type" FROM "031_1" AS "LHS" INNER JOIN "031_2" AS "RHS" ON ("LHS"."channelid" = "RHS"."channelid")) WHERE ("type" = 'public' AND "accountid" = 'Dave') ORDER BY c1, c2 NULLS LAST, c3 NULLS LAST;

/*
Gold Result:
(1, 'Dave', 1)
(2, 'Dave', 2)
*/

-- Prediction Query
SELECT '031_2'.channelID, accountID, role FROM "031_2" JOIN "031_1" ON '031_2'.channelID = '031_1'.channelID WHERE AccountID = 'Dave' AND type = 'public';

/*
Prediction Result:
(2, 'Dave', 2)
(1, 'Dave', 1)
*/