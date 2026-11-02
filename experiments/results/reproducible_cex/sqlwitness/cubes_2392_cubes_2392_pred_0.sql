-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (5001, NULL, 5000.0, 5001.0, NULL, 'default1'), (1, NULL, 1.0, 4999.0, NULL, NULL), (4999, 'default2', 0.0, 1.0, 'default1', 'default1'), (5000, 'default2', NULL, 5000.0, NULL, NULL), (0, NULL, 5000.0, 5000.0, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height >= 5000.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5000;

/*
Prediction Result:
*/