-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests DISTINCT (duplicate Class values), ORDER BY ASC (unsorted insertion order), and proper column projection (Class vs Name).
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Daytona', 'Florida', 100000.0, 1959.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Race Alpha', 'GT3', '2023-05-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'Race Beta', 'Formula 1', '2023-06-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '1', 'Race Gamma', 'GT3', '2023-07-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '1', 'Race Delta', 'LMP1', '2023-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM race ORDER BY CLASS;

/*
Gold Result:
('Formula 1',)
('GT3',)
('LMP1',)
*/

-- Prediction Query
SELECT DISTINCT CLASS FROM race;

/*
Prediction Result:
('GT3',)
('Formula 1',)
('LMP1',)
*/