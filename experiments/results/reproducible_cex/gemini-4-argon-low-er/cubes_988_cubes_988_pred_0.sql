-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'City A', 50000.0, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Track B', 'City B', 10000.0, 2005.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Track C', 'City C', 5000.0, 2010.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Track A', 50000.0)
('Track B', 10000.0)
('Track C', 5000.0)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
('Track C', 5000.0)
('Track B', 10000.0)
*/