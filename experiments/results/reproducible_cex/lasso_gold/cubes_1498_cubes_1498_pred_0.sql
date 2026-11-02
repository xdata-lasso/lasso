-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1086, 'Sandra Parker', 'article', 1087.5, 1088.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1091, 'Jenny Lewis', 'car', 1088.5, 1089.5);
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1089, 'Keith Miller', 'sign', 1090.5, 'mention');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1094, 'John Pierce', 'evidence', 1095.5, 'news');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1086, 1089, 'Morning');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1091, 1094, 'Morning');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."channel_id" AS "channel_id", "LHS"."name" AS "name", "LHS"."owner" AS "owner", "LHS"."share_in_percent" AS "share_in_percent", "LHS"."rating_in_percent" AS "rating_in_percent", "RHS"."program_id" AS "program_id", "RHS"."time_of_day" AS "time_of_day" FROM "channel" AS "LHS" INNER JOIN (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning')) AS RHS ON (LHS.channel_id = RHS.channel_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Jenny Lewis',)
('Sandra Parker',)
*/

-- Prediction Query
SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Morning';

/*
Prediction Result:
('Sandra Parker',)
('Jenny Lewis',)
*/