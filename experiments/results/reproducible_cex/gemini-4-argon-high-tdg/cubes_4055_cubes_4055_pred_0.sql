-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Zeta', 'USA', 2022.0, 'OwnerA');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'Alpha', 'UK', 2015.0, 'OwnerA');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (3, 'Beta', 'Canada', 2018.0, 'OwnerA');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (4, 'Gamma', 'USA', 2021.0, 'OwnerB');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (5, 'Delta', 'UK', 2010.0, 'OwnerB');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (10, 'Chan1', 'OwnerB', 25.5, 12.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (20, 'Chan2', 'OwnerA', 30.0, 15.5);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (10, 1, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (20, 4, 'Morning');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (10, 1, '2023-01-01', 18.5);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (20, 4, '2023-01-02', 22.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.program_id AS program_id_other, RHS.name AS name_other, RHS.origin AS origin_other FROM (SELECT program_id, name, origin, MAX(launch) OVER () AS launch, OWNER FROM program) AS LHS INNER JOIN program AS RHS ON (LHS.launch = RHS.launch AND LHS.owner = RHS.owner)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch DESC, program.program_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta',)
*/