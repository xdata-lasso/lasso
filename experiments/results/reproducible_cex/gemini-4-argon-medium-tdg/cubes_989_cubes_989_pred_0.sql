-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Name and Location, and NULLS LAST behavior on Track_ID.
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, NULL, 'Location B', 5000.0, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, NULL, 'Location A', 10000.0, 1995.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Apex Circuit', NULL, NULL, NULL);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Apex Circuit', 'USA', 25000.0, 2010.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
(None, 'Location A')
(None, 'Location B')
('Apex Circuit', None)
('Apex Circuit', 'USA')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
(None, 'Location A')
('Apex Circuit', None)
(None, 'Location B')
('Apex Circuit', 'USA')
*/