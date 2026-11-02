-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Sunset Speedway', 'Miami, FL', 50000.0, 1995.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Apex Circuit', 'Austin, TX', 80000.0, 2012.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Thunder Valley', 'Austin, TX', 45000.0, 1988.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Mystery Track', NULL, 10000.0, 2000.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (101, '2', 'Grand Prix', 'Class A', '2023-05-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (102, '2', 'Sprint Cup', 'Class B', '2023-05-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
(None,)
('Austin, TX',)
('Austin, TX',)
('Miami, FL',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('Miami, FL',)
('Austin, TX',)
(None,)
*/