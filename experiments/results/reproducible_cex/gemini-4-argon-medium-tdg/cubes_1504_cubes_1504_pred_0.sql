-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Share_in_percent DESC, distinguishing Share_in_percent from Rating_in_percent, Owner vs Name, and ensuring unreferenced channels are still considered.
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Channel Alpha', 'Owner Alpha', 15.5, 45.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Channel Beta', 'Owner Beta', 35.2, 12.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'Channel Gamma', 'Owner Gamma', 22.8, 30.5);
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (10, 'Morning Show', 'USA', 2010.0, 'Program Owner A');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 10, 'Morning');
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (1, 10, '2023-01-01', 99.9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT OWNER FROM (SELECT * FROM (SELECT * FROM channel ORDER BY share_in_percent DESC, channel.channel_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Owner Beta',)
*/

-- Prediction Query
SELECT OWNER FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Owner Alpha',)
*/