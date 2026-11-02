-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of order Pilot_ID vs Pilot_name), duplicate names (testing DISTINCT vs ALL), and NULL values in Pilot_name.
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (1, 'Charlie', 2, 35, 'USA', 'Captain', 2015, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (2, 'Alice', 1, 40, 'UK', 'Commander', 2010, 'Bravo');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (3, 'Alice', 3, 28, 'Canada', 'First Officer', 2019, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (4, 'Bob', 2, 32, 'Australia', 'Captain', 2017, 'Charlie');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (5, NULL, 4, 25, 'USA', 'Trainee', 2021, 'Bravo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM pilot ORDER BY pilot_name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Charlie',)
('Bob',)
('Alice',)
(None,)
*/