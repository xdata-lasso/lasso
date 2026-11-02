-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Ch1', 'Own1', 10.0, 5.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Ch2', 'Own2', 20.0, 10.0);
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'News', 'USA', 2000.0, 'CorpA');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Sports', 'UK', 2005.0, 'CorpB');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 2, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 2, 'Evening');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 1, 'Night');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.origin AS origin_other FROM program AS LHS INNER JOIN (SELECT name, origin, COUNT(*) AS n FROM (SELECT LHS.channel_id AS channel_id, LHS.program_id AS program_id, LHS.time_of_day AS time_of_day, RHS.name AS name, RHS.origin AS origin, RHS.launch AS launch, RHS.owner AS OWNER FROM broadcast AS LHS INNER JOIN program AS RHS ON (LHS.program_id = RHS.program_id)) GROUP BY name, origin) AS RHS ON (LHS.program_id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('News',)
('Sports',)
*/

-- Prediction Query
SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id GROUP BY t2.program_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('News',)
*/