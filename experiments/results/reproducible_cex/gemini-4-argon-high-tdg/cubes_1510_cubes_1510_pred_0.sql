-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Zeta', 'Canada', 2000.0, 'NetA');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'Alpha', 'USA', 1990.0, 'NetZ');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (3, 'Beta', 'Mexico', 2010.0, 'NetM');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (4, 'Delta', 'UK', 2.0, 'NetD');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (5, 'Epsilon', 'France', 2020.0, 'NetE');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (6, 'Gamma', 'Spain', 2015.0, 'NetG');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (101, 'Ch_A', 'Own_1', 10.5, 5.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (102, 'Ch_B', 'Own_2', 20.0, 6.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (103, 'Ch_C', 'Own_3', 30.0, 7.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (104, 'Ch_D', 'Own_4', 15.0, 4.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (105, 'Ch_E', 'Own_5', 12.0, 3.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (106, 'Ch_F', 'Own_6', 8.0, 2.0);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (101, 1, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (101, 2, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (102, 2, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (101, 3, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (102, 3, 'Afternoon');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (103, 3, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (101, 4, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (102, 4, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (101, 5, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (102, 5, 'Afternoon');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (103, 5, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (104, 5, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (105, 5, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (106, 5, 'Evening');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (101, 4, '2023-01-01', 11.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (102, 4, '2023-01-02', 12.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (103, 4, '2023-01-03', 13.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (104, 4, '2023-01-04', 14.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.origin AS origin_other FROM program AS LHS INNER JOIN (SELECT name, origin, COUNT(*) AS n FROM (SELECT LHS.channel_id AS channel_id, LHS.program_id AS program_id, LHS.time_of_day AS time_of_day, RHS.name AS name, RHS.origin AS origin, RHS.launch AS launch, RHS.owner AS OWNER FROM broadcast AS LHS INNER JOIN program AS RHS ON (LHS.program_id = RHS.program_id)) GROUP BY name, origin) AS RHS ON (LHS.program_id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id GROUP BY t2.program_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Epsilon',)
*/