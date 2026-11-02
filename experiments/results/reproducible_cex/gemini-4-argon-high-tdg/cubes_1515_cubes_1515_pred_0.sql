-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (101, 'Morning Show', 'USA', 1998.0, 'Network A');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (102, 'Evening News', 'UK', 2004.0, 'Network B');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (103, 'Unbroadcast Pilot', 'Canada', 2020.0, 'Indie Studio');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Channel One', 'Diff Owner 1', 25.5, 12.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Channel Two', 'Diff Owner 2', 18.0, 9.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Empty Channel', 'Network A', 5.0, 2.1);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 101, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 101, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 102, 'Night');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 101, '2023-01-01', 30.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (2, 101, '2023-01-02', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, origin, OWNER FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Evening News', 'UK', 'Network B')
('Morning Show', 'USA', 'Network A')
('Unbroadcast Pilot', 'Canada', 'Indie Studio')
*/

-- Prediction Query
SELECT name, origin, OWNER FROM program;

/*
Prediction Result:
('Morning Show', 'USA', 'Network A')
('Evening News', 'UK', 'Network B')
('Unbroadcast Pilot', 'Canada', 'Indie Studio')
*/