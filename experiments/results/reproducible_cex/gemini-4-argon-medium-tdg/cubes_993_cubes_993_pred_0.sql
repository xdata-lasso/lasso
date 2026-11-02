-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Daytona', 'FL', 100000.0, 1959.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (20, '1', 'Bravo Race', 'GT1', '2023-05-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (10, '1', 'Alpha Race', 'GT2', '2023-06-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (30, '1', 'Alpha Race', 'GT3', '2023-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, date FROM race ORDER BY name, race.race_id NULLS LAST;

/*
Gold Result:
('Alpha Race', 'GT2', '2023-06-01')
('Alpha Race', 'GT3', '2023-04-01')
('Bravo Race', 'GT1', '2023-05-01')
*/

-- Prediction Query
SELECT name, CLASS, date FROM race;

/*
Prediction Result:
('Alpha Race', 'GT2', '2023-06-01')
('Bravo Race', 'GT1', '2023-05-01')
('Alpha Race', 'GT3', '2023-04-01')
*/