-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1001, 'Allison Hill', '819 Johnson Course
East William, AK 74064', 1002.5, 2000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('Allison Hill', 1002.5)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
*/