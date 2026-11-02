-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (1, 'default1', 1.0, 0.0, 'default2', NULL), (0, NULL, NULL, 2.0, 'default2', NULL), (2, 'default1', 1.0, 0.0, 'default2', 'default1'), (3, 'default2', NULL, 2.0, 'default1', 'default2'), (4, 'default1', 2.0, 2.0, 'default2', NULL), (5, NULL, 0.0, NULL, NULL, 'default1'), (6, 'default2', NULL, NULL, NULL, NULL), (7, NULL, NULL, 2.0, 'default2', 'default1'), (8, NULL, 2.0, 0.0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY mountain_id) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/