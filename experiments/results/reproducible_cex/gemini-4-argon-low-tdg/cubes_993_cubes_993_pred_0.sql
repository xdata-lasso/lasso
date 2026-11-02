-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (ASC), secondary ordering by Race_ID (ASC) on ties,
-- inverse correlation between Race_ID and Name, and anti-DISTINCT (duplicate projection rows).
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (1, 'Daytona', 'FL', 100000.0, 1959.0);
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (30, '1', 'Alpha Race', 'Class B', '2023-05-01');
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (10, '1', 'Beta Race', 'Class C', '2023-01-01');
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (20, '1', 'Beta Race', 'Class A', '2023-03-01');
INSERT INTO "race" ("Race_ID", "Track_ID", "Name", "Class", "Date") VALUES (40, '1', 'Beta Race', 'Class A', '2023-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, date FROM race ORDER BY name, race.race_id NULLS LAST;

/*
Gold Result:
('Alpha Race', 'Class B', '2023-05-01')
('Beta Race', 'Class C', '2023-01-01')
('Beta Race', 'Class A', '2023-03-01')
('Beta Race', 'Class A', '2023-03-01')
*/

-- Prediction Query
SELECT name, CLASS, date FROM race;

/*
Prediction Result:
('Beta Race', 'Class C', '2023-01-01')
('Beta Race', 'Class A', '2023-03-01')
('Alpha Race', 'Class B', '2023-05-01')
('Beta Race', 'Class A', '2023-03-01')
*/