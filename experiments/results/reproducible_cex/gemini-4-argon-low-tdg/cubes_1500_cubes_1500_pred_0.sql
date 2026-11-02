-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), and confusion between program.Name and channel.Name.
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (20, 'Zeta', 'USA', 2010.0, 'Owner1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (10, 'Alpha', 'UK', 2015.0, 'Owner2');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (15, 'Beta', 'CA', 2012.0, 'Owner3');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (25, 'Beta', 'AU', 2018.0, 'Owner4');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, 'ChannelX', 'Owner1', 15.5, 10.2);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, 'ChannelY', 'Owner2', 20.0, 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch, program.program_id NULLS LAST;

/*
Prediction Result:
('Zeta',)
('Beta',)
('Alpha',)
('Beta',)
*/