-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Apex', 'Texas', 10000.0, 1999.9);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Bravo', 'Nevada', 25000.5, 2000.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Crest', 'Florida', 30000.0, 2000.1);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Delta', 'Ohio', 15000.0, 2010.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (5, 'Echo', 'Maine', 5000.0, NULL);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (101, 2, 'Spring Sprint', 'A', '2021-04-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (102, 2, 'Autumn Dash', 'B', '2021-10-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Bravo', 25000.5)
('Crest', 30000.0)
('Delta', 15000.0)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
('Delta', 15000.0)
('Crest', 30000.0)
*/