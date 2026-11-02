-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'News', 'US', 2000.0, 'Owner1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'News', 'UK', 2005.0, 'Owner2');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Ch1', 'Owner1', 10.0, 5.0);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 1, 'Morning');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "program" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning')) AS RHS WHERE (LHS.program_id = RHS.program_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('News',)
*/

-- Prediction Query
SELECT name FROM program EXCEPT SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id WHERE t2.Time_of_day = 'Morning';

/*
Prediction Result:
*/