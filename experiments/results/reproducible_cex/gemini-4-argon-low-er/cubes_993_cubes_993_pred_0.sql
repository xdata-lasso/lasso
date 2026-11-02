-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (Track_ID, Name, Location, Seating, Year_Opened) VALUES (1, 'Track A', 'Location A', 1000.0, 2000.0);
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (1, '1', 'Z Race', 'Class 1', '2023-01-01');
INSERT INTO race (Race_ID, Track_ID, Name, Class, Date) VALUES (2, '1', 'A Race', 'Class 2', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, date FROM race ORDER BY name, race.race_id NULLS LAST;

/*
Gold Result:
('A Race', 'Class 2', '2023-01-02')
('Z Race', 'Class 1', '2023-01-01')
*/

-- Prediction Query
SELECT name, CLASS, date FROM race;

/*
Prediction Result:
('Z Race', 'Class 1', '2023-01-01')
('A Race', 'Class 2', '2023-01-02')
*/