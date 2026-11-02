-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Monza', 'Italy', 113860.0, 1922.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Aintree', 'UK', 75000.0, 1954.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Spa', 'Belgium', 70000.0, 1921.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (101, 1, 'Italian GP', 'F1', '2023-09-03');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (102, 1, 'Monza 1000km', 'WEC', '2023-07-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Aintree', 'UK')
('Monza', 'Italy')
('Spa', 'Belgium')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
('Monza', 'Italy')
('Aintree', 'UK')
('Spa', 'Belgium')
*/