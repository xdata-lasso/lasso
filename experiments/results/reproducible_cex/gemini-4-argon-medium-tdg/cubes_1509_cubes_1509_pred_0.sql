-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Morning News', 'Beijing', 2005.0, 'CCTV');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'Evening News', 'Shanghai', 2010.0, 'SMG');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (3, 'Morning News', 'Guangzhou', 2012.0, 'GDTV');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (4, 'Morning News', 'Shenzhen', 2015.0, 'SZMG');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (5, 'Late Show', 'Anhui', 2018.0, 'AHTV');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "program" WHERE ("origin" <> 'Beijing') ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Evening News',)
('Late Show',)
('Morning News',)
('Morning News',)
*/

-- Prediction Query
SELECT name FROM program WHERE origin <> 'Beijing';

/*
Prediction Result:
('Evening News',)
('Morning News',)
('Morning News',)
('Late Show',)
*/