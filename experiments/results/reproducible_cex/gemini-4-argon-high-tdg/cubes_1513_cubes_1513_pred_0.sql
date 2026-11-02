-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'News Today', 'USA', 2001.0, 'MediaCorp');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (2, 'Sports Desk', 'UK', 2005.0, 'GlobalNet');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (3, 'Late Show', 'Canada', 2010.0, 'NorthStar');
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (4, 'Unused Program', 'France', 2015.0, 'EuroVision');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Channel One', 'AlphaGroup', 25.5, 12.3);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Channel Two', 'BetaGroup', 18.0, 8.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Channel Three', 'GammaGroup', 10.2, 4.1);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'Unused Channel', 'DeltaGroup', 5.0, 1.2);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 1, 'Night');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 2, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 3, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 1, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (3, 1, 'Evening');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 2, NULL);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 3, NULL);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (3, 2, 'Afternoon');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (3, 3, 'Afternoon');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 4, 'Afternoon');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 1, '2023-01-01', 15.0);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 2, '2023-01-02', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, time_of_day FROM (SELECT time_of_day, COUNT(*) AS n FROM broadcast GROUP BY time_of_day) ORDER BY count___, time_of_day NULLS LAST;

/*
Gold Result:
(1, 'Night')
(2, 'Evening')
(2, 'Morning')
(2, None)
(3, 'Afternoon')
*/

-- Prediction Query
SELECT COUNT(*), time_of_day FROM broadcast GROUP BY time_of_day;

/*
Prediction Result:
(2, None)
(3, 'Afternoon')
(2, 'Evening')
(2, 'Morning')
(1, 'Night')
*/