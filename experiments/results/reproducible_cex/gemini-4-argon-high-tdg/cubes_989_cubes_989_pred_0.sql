-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Monaco', 'Monte Carlo', 100000.0, 1929.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Silverstone', 'UK', 50000.0, 1948.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Silverstone', 'USA', 30000.0, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Silverstone', 'AUS', 40000.0, 1920.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (5, 'Spa', 'Belgium', 70000.0, 1921.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Monaco', 'Monte Carlo')
('Silverstone', 'UK')
('Silverstone', 'USA')
('Silverstone', 'AUS')
('Spa', 'Belgium')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
('Silverstone', 'UK')
('Silverstone', 'USA')
('Silverstone', 'AUS')
('Monaco', 'Monte Carlo')
('Spa', 'Belgium')
*/