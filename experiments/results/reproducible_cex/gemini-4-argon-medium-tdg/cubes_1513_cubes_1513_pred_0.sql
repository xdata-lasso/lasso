-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(time_of_day) by including a NULL time_of_day group.
-- 2. ORDER BY count___ ASC vs DESC (counts 1, 2, 3).
-- 3. Tie-breaking on ORDER BY time_of_day ASC vs DESC and NULLS LAST vs NULLS FIRST (Night, Morning, and NULL all have count 1).
-- 4. COUNT(*) vs COUNT(DISTINCT Channel_ID) and COUNT(DISTINCT Program_ID) (Evening has 2 rows sharing Channel_ID=1; Afternoon has 3 rows sharing Program_ID=1).
-- 5. Unmatched rows in parent tables (program 4, channel 4) and child table (broadcast_share) to kill mutants with erroneous INNER/LEFT JOINs.
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'ProgA', 'USA', 2000.0, 'Owner1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'ProgB', 'UK', 2005.0, 'Owner2');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (3, 'ProgC', 'CAN', 2010.0, 'Owner3');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (4, 'ProgUnmatched', 'AUS', 2015.0, 'Owner4');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Chan1', 'Owner1', 10.5, 5.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Chan2', 'Owner2', 20.0, 8.5);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'Chan3', 'Owner3', 15.0, 6.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (4, 'ChanUnmatched', 'Owner4', 5.0, 2.0);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 1, 'Afternoon');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 1, 'Afternoon');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (3, 1, 'Afternoon');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 2, 'Evening');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 3, 'Evening');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 2, 'Night');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 3, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (3, 3, NULL);
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (1, 1, '2023-01-01', 12.0);
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (1, 2, '2023-01-02', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, time_of_day FROM (SELECT time_of_day, COUNT(*) AS n FROM broadcast GROUP BY time_of_day) ORDER BY count___, time_of_day NULLS LAST;

/*
Gold Result:
(1, 'Morning')
(1, 'Night')
(1, None)
(2, 'Evening')
(3, 'Afternoon')
*/

-- Prediction Query
SELECT COUNT(*), time_of_day FROM broadcast GROUP BY time_of_day;

/*
Prediction Result:
(1, None)
(3, 'Afternoon')
(2, 'Evening')
(1, 'Morning')
(1, 'Night')
*/