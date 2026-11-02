-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'Location A', 50000.0, 1990.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Race Z', 'Class B', '2023-05-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'Race A', 'Class A', '2023-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (3, '1', 'Race M', 'Class B', '2023-03-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (4, '1', 'Race B', 'Class C', '2023-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM race ORDER BY CLASS;

/*
Gold Result:
('Class A',)
('Class B',)
('Class C',)
*/

-- Prediction Query
SELECT DISTINCT CLASS FROM race;

/*
Prediction Result:
('Class B',)
('Class A',)
('Class C',)
*/