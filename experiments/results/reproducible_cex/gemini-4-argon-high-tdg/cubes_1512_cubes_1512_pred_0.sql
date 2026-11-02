-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (5, 'Beta', 'Australia', 1980.0, 'NBC');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (10, 'Middle', 'USA', 2005.0, 'Fox');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (20, 'Zeta', 'Canada', 1998.0, 'CBS');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (30, 'Alpha', 'UK', 2020.0, 'ABC');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (50, 'Omega', 'Zimbabwe', 2010.0, 'ZetaCorp');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Channel Max', 'ZetaCorp', 45.5, 12.3);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Channel Min', 'ABC', 10.0, 2.5);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 50, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 30, 'Morning');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 50, '2023-01-01', 55.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (2, 5, '2023-01-02', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM program ORDER BY name DESC, program.program_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Zeta',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch DESC, program.program_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/