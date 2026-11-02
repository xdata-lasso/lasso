-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (1, 'B', 'Location 1', 1000.0, 2000.0);
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (2, 'A', 'Location 2', 2000.0, 2001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('A', 'Location 2')
('B', 'Location 1')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
('B', 'Location 1')
('A', 'Location 2')
*/