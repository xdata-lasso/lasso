-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1012, 'Lance Hoffman', 'sense', 1013.5, 1014.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1015, 'Kimberly Robinson', 'perform', 1016.5, NULL);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1018, 'Sean Blake', 'perform', 1019.5, 1020.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumrating_in_percent AS sum_rating_in_percent_, OWNER FROM (SELECT OWNER, SUM(rating_in_percent) AS sumrating_in_percent FROM channel GROUP BY OWNER) ORDER BY sum_rating_in_percent_, OWNER NULLS LAST;

/*
Gold Result:
(1014.5, 'sense')
(1020.5, 'perform')
*/

-- Prediction Query
SELECT SUM(Rating_in_percent), OWNER FROM channel GROUP BY OWNER;

/*
Prediction Result:
(1020.5, 'perform')
(1014.5, 'sense')
*/