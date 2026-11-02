-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO program (Program_ID, Name, Origin, Launch, Owner) VALUES (1, 'Daily Chef', 'France', 2019.0, 'Prime TV');
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Prime 1', 'Prime TV', 14.0, 3.1);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (2, 'Prime 2', 'Prime TV', 11.0, 2.4);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (3, 'Prime 3', 'Prime TV', 9.0, 1.8);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (4, 'Star A', 'Star Net', 22.0, 6.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (5, 'Star B', 'Star Net', 19.0, 5.2);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (6, 'Indie X', NULL, 5.0, 1.0);
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (7, 'Indie Y', NULL, 4.5, 0.9);
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (1, 1, 'Noon');
INSERT INTO broadcast (Channel_ID, Program_ID, Time_of_day) VALUES (4, 1, 'Evening');
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (1, 1, '2023-03-15', 14.2);
INSERT INTO broadcast_share (Channel_ID, Program_ID, Date, Share_in_percent) VALUES (4, 1, '2023-03-15', 21.8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_owner_ FROM (SELECT COUNT(*) AS n FROM (SELECT OWNER, COUNT(*) AS n FROM channel GROUP BY OWNER)) ORDER BY count_distinct_owner_;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT OWNER) FROM channel;

/*
Prediction Result:
(2,)
*/