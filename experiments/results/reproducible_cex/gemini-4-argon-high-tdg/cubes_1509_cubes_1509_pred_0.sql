-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Zeta Show', 'Shanghai', 2015.0, 'SMG');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'Capital Report', 'Beijing', 2010.0, 'BTV');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (3, 'Alpha Hour', 'Anhui', 2020.0, 'ATV');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (4, 'Beta Talk', 'Chongqing', 2018.0, 'CQTV');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (10, 'Channel One', 'SMG', 12.5, 4.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (20, 'Channel Two', 'BTV', 8.0, 2.1);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (10, 1, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (20, 1, 'Evening');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (20, 2, 'Night');
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (10, 1, '2023-01-01', 15.2);
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (20, 1, '2023-01-02', 9.8);
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (20, 2, '2023-01-03', 11.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "program" WHERE ("origin" <> 'Beijing') ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Alpha Hour',)
('Beta Talk',)
('Zeta Show',)
*/

-- Prediction Query
SELECT name FROM program WHERE origin <> 'Beijing';

/*
Prediction Result:
('Zeta Show',)
('Alpha Hour',)
('Beta Talk',)
*/