-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1007, 'Daniel Wagner', 'agreement', 1008.5, 1009.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1013, 'Abigail Shaffer', 'save', 1014.5, 1015.5);
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1, 'Michelle Miles', 'kind', 1010.5, 'discussion');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1011, 'Michelle Miles', 'list', 1012.5, 'perform');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1019, 'Donald Lewis', NULL, 1016.5, 'great');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1017, 'Donald Lewis', NULL, 1018.5, 'best');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1007, 1011, 'fall');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1013, 1017, 'husband');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.origin AS origin_other FROM program AS LHS INNER JOIN (SELECT name, origin, COUNT(*) AS n FROM (SELECT LHS.channel_id AS channel_id, LHS.program_id AS program_id, LHS.time_of_day AS time_of_day, RHS.name AS name, RHS.origin AS origin, RHS.launch AS launch, RHS.owner AS OWNER FROM broadcast AS LHS INNER JOIN program AS RHS ON (LHS.program_id = RHS.program_id)) GROUP BY name, origin) AS RHS ON (LHS.program_id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('Michelle Miles',)
*/

-- Prediction Query
SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id GROUP BY t2.program_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Donald Lewis',)
*/