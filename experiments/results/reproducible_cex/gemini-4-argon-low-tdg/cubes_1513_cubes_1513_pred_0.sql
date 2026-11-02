-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard grouping, distinct counts, tie-breaking by time_of_day ASC, and extra unreferenced rows in other tables (catches INNER JOIN / LEFT JOIN mutations).
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Prog A', 'US', 2000.0, 'Own1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'Prog B', 'UK', 2005.0, 'Own2');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (3, 'Prog C', 'CA', 2010.0, 'Own3');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (4, 'Unused Prog', 'AU', 2015.0, 'Own4');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Chan 1', 'Own1', 10.5, 5.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Chan 2', 'Own2', 20.0, 8.5);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'Chan 3', 'Own3', 15.0, 6.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (4, 'Unused Chan', 'Own4', 5.0, 2.0);
-- Night: 1, Evening: 2, Morning: 2, Afternoon: 3
-- Insertion order intentionally scrambled relative to expected output order.
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 1, 'Afternoon');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 2, 'Evening');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 3, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 1, 'Afternoon');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 2, 'Night');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 3, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (3, 1, 'Afternoon');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (3, 2, 'Evening');
-- Only a subset in broadcast_share to catch faulty joins with broadcast_share
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (1, 1, '2023-01-01', 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, time_of_day FROM (SELECT time_of_day, COUNT(*) AS n FROM broadcast GROUP BY time_of_day) ORDER BY count___, time_of_day NULLS LAST;

/*
Gold Result:
(1, 'Night')
(2, 'Evening')
(2, 'Morning')
(3, 'Afternoon')
*/

-- Prediction Query
SELECT COUNT(*), time_of_day FROM broadcast GROUP BY time_of_day;

/*
Prediction Result:
(3, 'Afternoon')
(2, 'Evening')
(2, 'Morning')
(1, 'Night')
*/