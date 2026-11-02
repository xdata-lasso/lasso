-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests the non-standard join condition (program.Program_ID = broadcast.Channel_ID) vs standard FK join (program.Program_ID = broadcast.Program_ID), and table substitution (program vs channel).
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'ProgA', 'US', 2000.0, 'ProgOwner_1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'ProgB', 'UK', 2005.0, 'ProgOwner_2');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'ChanA', 'ChanOwner_1', 15.5, 8.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'ChanB', 'ChanOwner_2', 20.0, 9.5);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 2, 'Evening');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "owner" FROM (SELECT "program_id", "name", "origin", "launch", "owner", "program_id_other", "time_of_day", "program_id" AS "channel_id" FROM (SELECT "LHS"."program_id" AS "program_id", "LHS"."name" AS "name", "LHS"."origin" AS "origin", "LHS"."launch" AS "launch", "LHS"."owner" AS "owner", "RHS"."program_id" AS "program_id_other", "RHS"."time_of_day" AS "time_of_day" FROM "program" AS "LHS" INNER JOIN "broadcast" AS "RHS" ON ("LHS"."program_id" = "RHS"."channel_id"))) WHERE ("time_of_day" <> 'Morning' OR "time_of_day" = 'Night') ORDER BY OWNER, "owner" NULLS LAST;

/*
Gold Result:
('ProgOwner_1',)
*/

-- Prediction Query
SELECT t1.owner FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id WHERE t2.Time_of_day = 'Morning' INTERSECT SELECT t1.owner FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id WHERE t2.Time_of_day = 'Night';

/*
Prediction Result:
*/