-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (7, 8, '14', '14', '14');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (6, 9, '14', '14', '14');
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (8, NULL, NULL, 14, 2000);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (9, NULL, '12', 14, 2001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
(None, 14.0)
(None, 14.0)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
(None, 14.0)
*/