-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core tie-breaking, duplicate elimination (SELECT vs DISTINCT), and ORDER BY direction/column swaps.
-- For 'Captain', Pilot_ID 10 -> 'Alpha', Pilot_ID 20 -> 'Zulu' (Pilot_ID ASC matches Team ASC).
-- For 'First Officer', Pilot_ID 5 -> 'Omega', Pilot_ID 15 -> 'Beta' (Pilot_ID ASC opposes Team ASC).
-- Also includes duplicate (Position, Team) pairs to kill SELECT DISTINCT mutants.
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (5, 'David', 2, 28, 'UK', 'First Officer', 2019, 'Omega');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (10, 'Alice', 1, 35, 'USA', 'Captain', 2015, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (15, 'Charlie', 3, 40, 'Canada', 'First Officer', 2012, 'Beta');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (20, 'Bob', 4, 30, 'Australia', 'Captain', 2018, 'Zulu');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (25, 'Eve', 1, 32, 'USA', 'Captain', 2016, 'Alpha');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION, team FROM pilot ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Captain', 'Alpha')
('Captain', 'Zulu')
('Captain', 'Alpha')
('First Officer', 'Omega')
('First Officer', 'Beta')
*/

-- Prediction Query
SELECT POSITION, Team FROM pilot;

/*
Prediction Result:
('First Officer', 'Omega')
('Captain', 'Alpha')
('First Officer', 'Beta')
('Captain', 'Zulu')
('Captain', 'Alpha')
*/