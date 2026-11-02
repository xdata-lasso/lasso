-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (Track_ID, Name, Location) VALUES (1, 'B', 'Loc1');
INSERT INTO track (Track_ID, Name, Location) VALUES (2, 'A', 'Loc2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('A', 'Loc2')
('B', 'Loc1')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
('B', 'Loc1')
('A', 'Loc2')
*/