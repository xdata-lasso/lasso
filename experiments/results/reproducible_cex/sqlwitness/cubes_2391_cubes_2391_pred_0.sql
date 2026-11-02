-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (2, 'default2', 1.0, NULL, 'default1', 'default1'), (1, 'default2', 2.0, 2.0, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
('default1',)
*/