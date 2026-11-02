-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1001, 'Allison Hill', 'dog', 1002.5, 1003.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1005, NULL, NULL, NULL, NULL);
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1001, 'Brian Yang', 'offer', 1004.5, 'begin');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1007, NULL, NULL, NULL, NULL);
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1005, 1001, 'Morning');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1005, 1007, 'Night');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1001, 1007, 'Morning');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1001, 1001, 'Night');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "channel_id", "name", "owner", "share_in_percent", "rating_in_percent", "channel_id_other", "time_of_day", "channel_id" AS "program_id" FROM (SELECT "LHS"."channel_id" AS "channel_id", "LHS"."name" AS "name", "LHS"."owner" AS "owner", "LHS"."share_in_percent" AS "share_in_percent", "LHS"."rating_in_percent" AS "rating_in_percent", "RHS"."channel_id" AS "channel_id_other", "RHS"."time_of_day" AS "time_of_day" FROM "channel" AS "LHS" INNER JOIN "broadcast" AS "RHS" ON ("LHS"."channel_id" = "RHS"."program_id"))) AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning' OR "time_of_day" = 'Night')) AS RHS WHERE (LHS.channel_id = RHS.channel_id AND LHS.time_of_day = RHS.time_of_day AND LHS.program_id = RHS.program_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Morning' INTERSECT SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Night';

/*
Prediction Result:
(None,)
('Allison Hill',)
*/