-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (Mountain_ID, Name, Height) VALUES (1, 'A', 100.0);
INSERT INTO mountain (Mountain_ID, Name, Height) VALUES (2, 'B', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY mountain_id) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/