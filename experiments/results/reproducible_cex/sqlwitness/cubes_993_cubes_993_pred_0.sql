-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (track_id, name, location, seating, year_opened) VALUES (1, 'default1', NULL, NULL, 1.0), (0, NULL, 'default2', NULL, NULL), (2, NULL, NULL, NULL, 0.0);
INSERT INTO race (race_id, track_id, name, class, date) VALUES (1, 2, NULL, 'default1', NULL), (0, 1, NULL, 'default1', 'default2'), (2, NULL, 'default1', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, date FROM race ORDER BY name, race.race_id NULLS LAST;

/*
Gold Result:
(None, 'default1', 'default2')
(None, 'default1', None)
('default1', None, 'default2')
*/

-- Prediction Query
SELECT name, CLASS, date FROM race;

/*
Prediction Result:
(None, 'default1', 'default2')
(None, 'default1', None)
('default1', None, 'default2')
*/