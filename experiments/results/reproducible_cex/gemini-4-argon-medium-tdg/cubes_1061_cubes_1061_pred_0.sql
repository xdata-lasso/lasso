-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Position, tie-breaking by Pilot_ID, and preservation of duplicate (Position, Team) pairs (refutes SELECT DISTINCT, ORDER BY Team, or missing secondary sort).
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (10, 'Alice', 1, 35, 'USA', 'Captain', 2010, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (2, 'Bob', 2, 28, 'UK', 'Captain', 2015, 'Beta');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (5, 'Charlie', 1, 40, 'Canada', 'Captain', 2008, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (1, 'Diana', 3, 25, 'USA', 'First Officer', 2018, 'Gamma');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION, team FROM pilot ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Captain', 'Beta')
('Captain', 'Alpha')
('Captain', 'Alpha')
('First Officer', 'Gamma')
*/

-- Prediction Query
SELECT POSITION, Team FROM pilot;

/*
Prediction Result:
('First Officer', 'Gamma')
('Captain', 'Beta')
('Captain', 'Alpha')
('Captain', 'Alpha')
*/