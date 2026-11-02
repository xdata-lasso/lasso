-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Sunset Speedway', 'Miami', 50000.0, 1995.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (2, 'Lone Star Circuit', 'Austin', 75000.0, 2005.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (3, 'Biscayne Oval', 'Miami', 30000.0, 1980.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (4, 'Harbor Park', 'Boston', 42000.0, 2010.0);
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (5, 'Ghost Track', NULL, 10000.0, 1970.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (101, '1', 'Summer Dash', 'A', '2023-06-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (102, '1', 'Winter Classic', 'B', '2023-12-15');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (103, '2', 'Texas Grand Prix', 'A', '2023-04-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
(None,)
('Austin',)
('Boston',)
('Miami',)
('Miami',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('Miami',)
('Austin',)
('Boston',)
(None,)
*/