-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests SUM vs SUM(DISTINCT), GROUP BY Owner vs GROUP BY Name, and tie-breaking in ORDER BY (same sum, different Owner).
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'SameName', 'OwnerZ', 10.0, 4.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'SameName', 'OwnerZ', 20.0, 4.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'DiffName', 'OwnerA', 15.0, 8.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (4, 'SameName', 'OwnerM', 25.0, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrating_in_percent AS sum_rating_in_percent_, OWNER FROM (SELECT OWNER, SUM(rating_in_percent) AS sumrating_in_percent FROM channel GROUP BY OWNER) ORDER BY sum_rating_in_percent_, OWNER NULLS LAST;

/*
Gold Result:
(5.0, 'OwnerM')
(8.0, 'OwnerA')
(8.0, 'OwnerZ')
*/

-- Prediction Query
SELECT SUM(Rating_in_percent), OWNER FROM channel GROUP BY OWNER;

/*
Prediction Result:
(8.0, 'OwnerA')
(5.0, 'OwnerM')
(8.0, 'OwnerZ')
*/