-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Prog_One', 'USA', 2001.0, 'Owner_A');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'Prog_Two', 'UK', 2005.0, 'Owner_B');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (3, 'Prog_Three', 'Canada', 2010.0, 'Owner_C');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (4, 'Prog_Four', 'France', 2015.0, 'Owner_D');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'Zeta TV', 'Owner_X', 15.5, 4.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'Alpha TV', 'Owner_Y', 22.0, 6.8);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (3, 'Beta TV', 'Owner_Z', 10.1, 2.5);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (4, 'Gamma TV', 'Owner_W', 8.0, 1.9);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (1, 1, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (2, 2, 'Night');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (3, 3, 'Afternoon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "channel_id", "name", "owner", "share_in_percent", "rating_in_percent", "channel_id_other", "time_of_day", "channel_id" AS "program_id" FROM (SELECT "LHS"."channel_id" AS "channel_id", "LHS"."name" AS "name", "LHS"."owner" AS "owner", "LHS"."share_in_percent" AS "share_in_percent", "LHS"."rating_in_percent" AS "rating_in_percent", "RHS"."channel_id" AS "channel_id_other", "RHS"."time_of_day" AS "time_of_day" FROM "channel" AS "LHS" INNER JOIN "broadcast" AS "RHS" ON ("LHS"."channel_id" = "RHS"."program_id"))) AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning' OR "time_of_day" = 'Night')) AS RHS WHERE (LHS.channel_id = RHS.channel_id AND LHS.time_of_day = RHS.time_of_day AND LHS.program_id = RHS.program_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alpha TV',)
('Zeta TV',)
*/

-- Prediction Query
SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Morning' INTERSECT SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Night';

/*
Prediction Result:
*/