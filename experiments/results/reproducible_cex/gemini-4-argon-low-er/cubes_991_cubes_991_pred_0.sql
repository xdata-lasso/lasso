-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (1, 'Track A', 'New York', 1000.0, 1990.0);
INSERT INTO "track" ("Track_ID", "Name", "Location", "Seating", "Year_Opened") VALUES (2, 'Track B', 'New York', 2000.0, 2000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
('New York',)
('New York',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('New York',)
*/