-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'New York', 50000.0, 1980.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Track B', 'Boston', 30000.0, 1995.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Track C', 'New York', 75000.0, 2005.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Track D', 'Chicago', 40000.0, 1990.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (101, '1', 'Summer Sprint', 'Class A', '2023-07-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (102, '1', 'Autumn Classic', 'Class B', '2023-10-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
('Boston',)
('Chicago',)
('New York',)
('New York',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('New York',)
('Boston',)
('Chicago',)
*/