-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Zeta Hour', 'UK', 2015.0, 'MediaCorp');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'Alpha News', 'USA', 2020.0, 'GlobalNet');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (3, 'Morning Show', 'Canada', 2010.0, 'NorthStar');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (4, 'Morning Show', 'Australia', 2018.0, 'SouthCross');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (5, 'Beta Talk', 'France', 2005.0, 'EuroVision');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (10, 'Channel One', 'GlobalNet', 25.5, 12.3);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (20, 'Channel Two', 'MediaCorp', 18.0, 9.5);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (10, 1, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (20, 1, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (10, 2, 'Morning');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (10, 1, '2023-01-01', 15.2);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (20, 1, '2023-01-02', 11.4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Alpha News',)
('Beta Talk',)
('Morning Show',)
('Morning Show',)
('Zeta Hour',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch, program.program_id NULLS LAST;

/*
Prediction Result:
('Beta Talk',)
('Morning Show',)
('Zeta Hour',)
('Morning Show',)
('Alpha News',)
*/