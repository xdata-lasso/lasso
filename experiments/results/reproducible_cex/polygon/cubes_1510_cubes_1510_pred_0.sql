-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (19, NULL, '27', 28, '29');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1, '30', NULL, NULL, NULL);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (18, '1', '1', 1, 1);
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (18, 1, NULL);
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (18, 19, '34');
INSERT INTO "broadcast_share" ("channel_id", "program_id", "date", "share_in_percent") VALUES (18, 1, '1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.origin AS origin_other FROM program AS LHS INNER JOIN (SELECT name, origin, COUNT(*) AS n FROM (SELECT LHS.channel_id AS channel_id, LHS.program_id AS program_id, LHS.time_of_day AS time_of_day, RHS.name AS name, RHS.origin AS origin, RHS.launch AS launch, RHS.owner AS OWNER FROM broadcast AS LHS INNER JOIN program AS RHS ON (LHS.program_id = RHS.program_id)) GROUP BY name, origin) AS RHS ON (LHS.program_id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('30',)
*/

-- Prediction Query
SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id GROUP BY t2.program_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('30',)
*/