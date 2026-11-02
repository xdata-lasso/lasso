-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Zulu Circuit', 'Miami', 50000.0, 2001.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Alpha Speedway', 'Austin', 35000.0, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Bravo Park', 'Dallas', 25000.0, 1999.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Charlie Downs', 'Houston', 40000.0, 1999.9);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (5, 'Delta Oval', 'Orlando', 60000.0, 2000.1);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (6, 'Echo Raceway', 'Tampa', 15000.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Alpha Speedway', 35000.0)
('Delta Oval', 60000.0)
('Zulu Circuit', 50000.0)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
('Zulu Circuit', 50000.0)
('Delta Oval', 60000.0)
*/