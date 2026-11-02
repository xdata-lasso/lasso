-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Name, Origin, Owner, and Program_ID (testing NULLS FIRST vs NULLS LAST, and erroneous WHERE IS NOT NULL filters).
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (10, NULL, 'USA', 2000.0, 'Owner1');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (5, NULL, 'UK', 2001.0, 'Owner2');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (1, 'Zeta', NULL, 2002.0, 'Owner3');
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (2, 'Zeta', 'France', NULL, NULL);
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (8, 'Gamma', 'Germany', 1999.0, 'Owner4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, origin, OWNER FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
(None, 'UK', 'Owner2')
(None, 'USA', 'Owner1')
('Gamma', 'Germany', 'Owner4')
('Zeta', None, 'Owner3')
('Zeta', 'France', None)
*/

-- Prediction Query
SELECT name, origin, OWNER FROM program;

/*
Prediction Result:
('Zeta', None, 'Owner3')
('Zeta', 'France', None)
(None, 'UK', 'Owner2')
('Gamma', 'Germany', 'Owner4')
(None, 'USA', 'Owner1')
*/