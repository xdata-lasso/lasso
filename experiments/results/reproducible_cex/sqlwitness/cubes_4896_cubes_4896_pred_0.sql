-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (4, 'default2', 3.0, 3.0, 'default2', 'default1'), (3, 'default1', 3.0, 1.0, NULL, 'default2'), (1, 'default1', 0.0, 0.0, 'default1', 'default2'), (0, 'default1', NULL, 0.0, 'default2', NULL), (2, NULL, 0.0, 1.0, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM mountain ORDER BY RANGE;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/