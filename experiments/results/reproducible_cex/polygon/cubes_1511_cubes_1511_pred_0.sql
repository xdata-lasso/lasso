-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (9, '10', '10', 10, '10');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (8, '10', '10', 10, '10');
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (11, '10', '13', 10, 10);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (10, '10', '13', 10, 10);
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (10, 8, '10');
INSERT INTO "broadcast_share" ("channel_id", "program_id", "date", "share_in_percent") VALUES (10, 8, '10', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_owner_ FROM (SELECT COUNT(*) AS n FROM (SELECT OWNER, COUNT(*) AS n FROM channel GROUP BY OWNER)) ORDER BY count_distinct_owner_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT OWNER) FROM channel;

/*
Prediction Result:
(1,)
*/