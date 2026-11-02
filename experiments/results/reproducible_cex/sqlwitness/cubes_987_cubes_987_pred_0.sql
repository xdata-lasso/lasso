-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (track_id, name, location, seating, year_opened) VALUES (1, 'default1', 'default2', 1.0, 1.0), (0, NULL, 'default1', NULL, 0.0), (2, 'default2', 'default1', 1.0, 1.0), (3, NULL, NULL, 0.0, NULL), (4, NULL, NULL, 1.0, NULL), (5, NULL, 'default1', 1.0, NULL), (6, NULL, NULL, NULL, 1.0), (7, 'default1', NULL, NULL, 0.0), (8, NULL, 'default2', 0.0, NULL), (9, NULL, NULL, 1.0, NULL), (10, 'default1', 'default2', 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM race ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM race;

/*
Prediction Result:
(0,)
*/