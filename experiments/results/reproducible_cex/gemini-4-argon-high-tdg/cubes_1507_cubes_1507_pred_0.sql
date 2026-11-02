-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (10, 'Morning News', 'USA', 1995.0, 'MediaCorp');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (20, 'Late Show', 'UK', 2005.0, 'BritNet');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Bravo', 'Zeta', 10.0, 40.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Alpha', 'Beta', 30.0, 10.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Charlie', 'Alpha_Owner', 20.0, 20.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'Alpha', 'Gamma', 5.0, 30.0);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 10, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 20, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 10, 'Afternoon');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (2, 10, '2023-01-01', 12.5);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (2, 20, '2023-01-02', 15.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (3, 10, '2023-01-03', 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM channel ORDER BY name, channel.channel_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Bravo',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST;

/*
Prediction Result:
('Bravo',)
('Alpha',)
('Charlie',)
('Alpha',)
*/