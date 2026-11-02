-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (primary) and Program_ID (secondary tie-breaker), plus duplicate row elimination (SELECT vs SELECT DISTINCT).
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (20, 'Alpha', 'USA', 2005.0, 'NetA');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (10, 'Alpha', 'UK', 2001.0, 'NetB');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (30, 'Alpha', 'UK', 2010.0, 'NetB');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (5, 'Beta', 'CA', 1999.0, 'NetC');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (15, 'Gamma', 'AU', 2020.0, 'NetA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, origin, OWNER FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Alpha', 'UK', 'NetB')
('Alpha', 'USA', 'NetA')
('Alpha', 'UK', 'NetB')
('Beta', 'CA', 'NetC')
('Gamma', 'AU', 'NetA')
*/

-- Prediction Query
SELECT name, origin, OWNER FROM program;

/*
Prediction Result:
('Beta', 'CA', 'NetC')
('Alpha', 'UK', 'NetB')
('Gamma', 'AU', 'NetA')
('Alpha', 'USA', 'NetA')
('Alpha', 'UK', 'NetB')
*/