-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'M1', 1000.0, 100.0, 'A', 'C1');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'M2', 2000.0, 200.0, 'B', 'C1');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'M3', 3000.0, 300.0, 'C', 'C1');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'M4', 4000.0, 400.0, 'D', 'C1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM mountain ORDER BY RANGE;

/*
Gold Result:
('A',)
('B',)
('C',)
('D',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
('D',)
('C',)
('B',)
*/