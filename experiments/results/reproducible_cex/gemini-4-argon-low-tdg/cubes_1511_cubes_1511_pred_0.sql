-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard duplicate elimination with GROUP BY vs non-distinct COUNT(*), plus NULL handling in GROUP BY vs COUNT(DISTINCT Owner).
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'News 24', 'MediaCorp', 15.5, 10.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Sports 24', 'MediaCorp', 12.0, 8.5);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'Movies 1', 'CinemaInc', 20.0, 15.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (4, 'Indie TV', NULL, 5.0, 2.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (5, 'Public TV', NULL, 3.0, 1.5);
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