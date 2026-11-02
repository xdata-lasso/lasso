-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1074, 'David Hoffman', 1077.5, 1080.5, 'Mr', 'Lithuania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1075, 'Kevin Hurst', 1084.5, 1089.5, 'Mr', 'Lithuania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1076, 'Daniel Bright', 1091.5, 1098.5, 'Mr', 'Lithuania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1083, 'Shannon Hernandez', 1086.5, 1089.5, 'benefit', 'Lithuania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1084, 'Michael Carlson', 1093.5, 1098.5, 'benefit', 'Lithuania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1085, 'Kyle Mcdonald', 1100.5, 1107.5, 'benefit', 'Lithuania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1092, 'Kyle Mcdonald', 1100.5, 1107.5, 'benefit', 'Lithuania');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
('Lithuania',)
('Lithuania',)
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
('Lithuania',)
*/