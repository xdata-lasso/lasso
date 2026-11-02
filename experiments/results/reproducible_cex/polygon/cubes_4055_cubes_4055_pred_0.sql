-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (10, NULL, '15', NULL, '16');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (19, NULL, '20', -635, '16');
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (11, '16', '16', 16, 16);
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (11, 19, '16');
INSERT INTO "broadcast_share" ("channel_id", "program_id", "date", "share_in_percent") VALUES (11, 19, '16', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.program_id AS program_id_other, RHS.name AS name_other, RHS.origin AS origin_other FROM (SELECT program_id, name, origin, MAX(launch) OVER () AS launch, OWNER FROM program) AS LHS INNER JOIN program AS RHS ON (LHS.launch = RHS.launch AND LHS.owner = RHS.owner)) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch DESC, program.program_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/