-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1006, 'Allen Robinson', 'mouth', 1007.5, 1008.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1011, 'Kevin Pacheco', 'according', 1012.5, 1013.5);
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1009, 'Kristina Baldwin', 'science', 1010.5, 'offer');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1014, 'Caitlin Henderson', 'fall', 1015.5, 'clearly');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1006, 1009, 'kind');
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1011, 1014, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, time_of_day FROM (SELECT time_of_day, COUNT(*) AS n FROM broadcast GROUP BY time_of_day) ORDER BY count___, time_of_day NULLS LAST;

/*
Gold Result:
(1, 'kind')
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), time_of_day FROM broadcast GROUP BY time_of_day;

/*
Prediction Result:
(1, None)
(1, 'kind')
*/