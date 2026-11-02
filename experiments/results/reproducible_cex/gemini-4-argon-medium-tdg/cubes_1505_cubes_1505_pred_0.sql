-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Ch1', 'OwnerA', 15.0, 2.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Ch2', 'OwnerA', 20.0, 2.5);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Ch3', 'OwnerB', 5.0, 10.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'Ch4', 'OwnerC', 50.0, 1.0);
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Prog1', 'US', 2020.0, 'OwnerX');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 1, 'Morning');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (2, 1, 'Evening');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrating_in_percent AS sum_rating_in_percent_, OWNER FROM (SELECT OWNER, SUM(rating_in_percent) AS sumrating_in_percent FROM channel GROUP BY OWNER) ORDER BY sum_rating_in_percent_, OWNER NULLS LAST;

/*
Gold Result:
(1.0, 'OwnerC')
(5.0, 'OwnerA')
(10.0, 'OwnerB')
*/

-- Prediction Query
SELECT SUM(Rating_in_percent), OWNER FROM channel GROUP BY OWNER;

/*
Prediction Result:
(5.0, 'OwnerA')
(10.0, 'OwnerB')
(1.0, 'OwnerC')
*/