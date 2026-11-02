-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (track_id, name, location, seating, year_opened) VALUES (1, NULL, 'default2', 1.0, NULL), (0, NULL, NULL, 0.0, 0.0), (2, 'default2', NULL, 0.0, 1.0);
INSERT INTO race (race_id, track_id, name, class, date) VALUES (1, 1, 'default1', 'default2', 'default1'), (0, NULL, NULL, NULL, NULL), (2, 0, NULL, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM race ORDER BY CLASS;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT CLASS FROM race;

/*
Prediction Result:
(None,)
('default2',)
*/