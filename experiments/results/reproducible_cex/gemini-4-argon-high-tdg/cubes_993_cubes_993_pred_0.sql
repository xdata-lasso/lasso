-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Ascot', 'UK', 70000.0, 1711.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Epsom', 'UK', 120000.0, 1661.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Unreferenced Track', 'USA', 50000.0, 1950.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Silver Cup', 'G1', '2023-05-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '2', 'Grand Prix', 'G3', '2023-09-15');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, NULL, 'Autumn Sprint', 'G2', '2023-10-20');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (10, '1', 'Grand Prix', 'G1', '2023-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, date FROM race ORDER BY name, race.race_id NULLS LAST;

/*
Gold Result:
('Autumn Sprint', 'G2', '2023-10-20')
('Grand Prix', 'G3', '2023-09-15')
('Grand Prix', 'G1', '2023-01-10')
('Silver Cup', 'G1', '2023-05-01')
*/

-- Prediction Query
SELECT name, CLASS, date FROM race;

/*
Prediction Result:
('Silver Cup', 'G1', '2023-05-01')
('Grand Prix', 'G3', '2023-09-15')
('Autumn Sprint', 'G2', '2023-10-20')
('Grand Prix', 'G1', '2023-01-10')
*/