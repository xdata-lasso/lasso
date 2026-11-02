-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'ProgA', 'US', 2000.0, 'Owner1');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'ProgB', 'US', 2020.0, 'Owner1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.program_id AS program_id_other, RHS.name AS name_other, RHS.origin AS origin_other FROM (SELECT program_id, name, origin, MAX(launch) OVER () AS launch, OWNER FROM program) AS LHS INNER JOIN program AS RHS ON (LHS.launch = RHS.launch AND LHS.owner = RHS.owner)) ORDER BY name;

/*
Gold Result:
('ProgA',)
('ProgB',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch DESC, program.program_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('ProgB',)
*/