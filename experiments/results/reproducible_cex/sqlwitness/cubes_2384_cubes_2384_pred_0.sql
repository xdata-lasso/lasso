-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (1, NULL, 0.0, NULL, 'default2', 'default2'), (2, 'default2', 1.0, NULL, NULL, 'default1'), (0, 'default2', 2.0, 0.0, NULL, NULL), (3, 'default2', 1.0, 2.0, 'default2', 'default2'), (4, 'default2', NULL, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT * FROM (SELECT * FROM (SELECT height, RANGE, COUNT(*) AS n FROM mountain GROUP BY height, RANGE) ORDER BY RANGE DESC) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT RANGE FROM mountain GROUP BY RANGE ORDER BY COUNT(*) DESC, RANGE NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/