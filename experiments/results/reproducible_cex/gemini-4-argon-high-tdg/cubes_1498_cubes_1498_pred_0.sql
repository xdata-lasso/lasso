-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (10, 'Prog_One', 'USA', 2010.0, 'OwnP1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (20, 'Prog_Two', 'UK', 2015.0, 'OwnP2');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Prog_Three', 'CA', 2020.0, 'OwnP3');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Zeta TV', 'Owner_A', 15.5, 8.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Alpha Network', 'Owner_B', 25.0, 12.1);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'Beta Channel', 'Owner_C', 10.0, 5.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (10, 'Wrong Join Channel', 'Owner_D', 5.0, 2.0);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 10, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 10, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 20, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (3, 1, 'Evening');
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (3, 1, '2023-01-01', 12.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."channel_id" AS "channel_id", "LHS"."name" AS "name", "LHS"."owner" AS "owner", "LHS"."share_in_percent" AS "share_in_percent", "LHS"."rating_in_percent" AS "rating_in_percent", "RHS"."program_id" AS "program_id", "RHS"."time_of_day" AS "time_of_day" FROM "channel" AS "LHS" INNER JOIN (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning')) AS RHS ON (LHS.channel_id = RHS.channel_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alpha Network',)
('Alpha Network',)
('Zeta TV',)
*/

-- Prediction Query
SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Morning';

/*
Prediction Result:
('Zeta TV',)
('Alpha Network',)
('Alpha Network',)
*/