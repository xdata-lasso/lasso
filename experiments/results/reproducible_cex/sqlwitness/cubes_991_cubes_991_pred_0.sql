-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (track_id, name, location, seating, year_opened) VALUES (1, NULL, 'default1', NULL, 1.0), (0, 'default2', 'default1', 1.0, 0.0), (2, NULL, 'default1', 1.0, 0.0), (3, 'default2', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM track ORDER BY LOCATION, track.track_id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM track;

/*
Prediction Result:
('default1',)
('default2',)
*/