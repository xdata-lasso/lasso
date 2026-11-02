-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO track (track_id, name, location, seating, year_opened) VALUES (1, NULL, 'default2', NULL, 0.0), (2, NULL, 'default2', 1.0, 2.0), (0, NULL, 'default1', 2.0, NULL), (3, NULL, 'default1', 0.0, 2.0), (4, NULL, 'default2', 1.0, NULL), (5, 'default1', 'default2', 2.0, 0.0), (6, 'default1', 'default2', NULL, 1.0), (7, NULL, NULL, NULL, NULL), (8, 'default2', 'default2', 2.0, 0.0), (9, 'default2', 'default2', NULL, 1.0);
INSERT INTO race (race_id, track_id, name, class, date) VALUES (1, 4, NULL, 'default1', 'default1'), (2, 5, 'default2', NULL, 'default2'), (0, 7, 'default1', 'default1', 'default1'), (3, 3, 'default1', 'default2', 'default2'), (4, 9, 'default2', 'default1', NULL), (5, 5, NULL, NULL, NULL), (6, NULL, 'default1', NULL, NULL), (7, 1, 'default2', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, n, MAX(n) OVER () AS maxn FROM (SELECT CLASS, COUNT(*) AS n FROM race GROUP BY CLASS)) WHERE (maxn = n) ORDER BY CLASS;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/