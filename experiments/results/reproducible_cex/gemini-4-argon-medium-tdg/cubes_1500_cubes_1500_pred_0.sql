-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'Zebra', 'USA', 2005.0, 'OwnerC');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Alpha', 'UK', 2020.0, 'OwnerA');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (3, 'Alpha', 'CA', 1995.0, 'OwnerB');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (4, 'Beta', 'AU', 2010.0, 'OwnerD');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (10, 'ChannelX', 'OwnerA', 25.5, 10.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (20, 'ChannelY', 'OwnerB', 15.0, 5.5);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (10, 1, 'Morning');
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (20, 1, 'Evening');
INSERT INTO "broadcast_share" ("Channel_ID", "Program_ID", "Date", "Share_in_percent") VALUES (10, 1, '2023-01-01', 12.3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Beta',)
('Zebra',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch, program.program_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Zebra',)
('Beta',)
('Alpha',)
*/