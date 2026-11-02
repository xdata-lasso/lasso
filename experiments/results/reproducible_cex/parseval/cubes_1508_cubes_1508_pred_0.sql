-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: program --
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1, 'lhs_84fde3', 'lhs_068273', 1.0, 'lhs_47c3be');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483647, 'lhs_41b668', 'lhs_309d51', 1.0, 'lhs_8b8ab7');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (2, 'lhs_84fde3', 'lhs_068273', 1.0, 'lhs_47c3be');

-- Inserting into table: channel --
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 475.173408);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (4, 'fe4hri', 'a2ypuzhsrwbb', 749.826493, 503.083789);

-- Inserting into table: broadcast --
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, 1, 'u7');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (4, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "owner" FROM (SELECT "program_id", "name", "origin", "launch", "owner", "program_id_other", "time_of_day", "program_id" AS "channel_id" FROM (SELECT "LHS"."program_id" AS "program_id", "LHS"."name" AS "name", "LHS"."origin" AS "origin", "LHS"."launch" AS "launch", "LHS"."owner" AS "owner", "RHS"."program_id" AS "program_id_other", "RHS"."time_of_day" AS "time_of_day" FROM "program" AS "LHS" INNER JOIN "broadcast" AS "RHS" ON ("LHS"."program_id" = "RHS"."channel_id"))) WHERE ("time_of_day" <> 'Morning' OR "time_of_day" = 'Night') ORDER BY OWNER, "owner" NULLS LAST;

/*
Gold Result:
('lhs_47c3be',)
*/

-- Prediction Query
SELECT t1.owner FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id WHERE t2.Time_of_day = 'Morning' INTERSECT SELECT t1.owner FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id WHERE t2.Time_of_day = 'Night';

/*
Prediction Result:
*/