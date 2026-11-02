-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (track_id, name, location, seating, year_opened) VALUES (0, 'default2', 'default1', NULL, 1.0), (1, 'default2', NULL, 0.0, 1.0), (2, 'default2', 'default2', NULL, 0.0), (3, 'default1', NULL, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM track ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
('default1', None)
('default2', 'default1')
('default2', None)
('default2', 'default2')
*/

-- Prediction Query
SELECT name, LOCATION FROM track;

/*
Prediction Result:
('default2', 'default1')
('default2', None)
('default2', 'default2')
('default1', None)
*/