-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Mountain_ID (ASC vs DESC), LIMIT 1 vs no limit, and ensures ordering by Mountain_ID is distinct from ordering by Name, Height, Prominence, Range, or Country.
-- Also tests queries that mistakenly INNER JOIN with climber (Mountain_ID 2 has no climbers) or query the climber table instead.
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (10, 'Alpha Peak', 1000.0, 100.0, 'Range A', 'Country A');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Zeta Peak', 5000.0, 500.0, 'Range Z', 'Country Z');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Beta Peak', 8000.0, 800.0, 'Range M', 'Country M');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 10, 'John Doe', 'USA', '10:00', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 5, 'Jane Smith', 'UK', '12:00', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY mountain_id) LIMIT 1);

/*
Gold Result:
('Zeta Peak',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta Peak',)
*/