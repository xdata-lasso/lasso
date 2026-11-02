-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (1999, 2000, 2004, 2005, 2010, NULL), AND vs OR logic, <= vs <, and missing WHERE clause.
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Alice', 1, 45, 'US', 'Captain', 1999, 'Alpha');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'Bob', 2, 40, 'UK', 'First Officer', 2000, 'Beta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (3, 'Charlie', 3, 38, 'CA', 'Flight Engineer', 2004, 'Gamma');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (4, 'David', 4, 35, 'AU', 'Cadet', 2005, 'Delta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (5, 'Eve', 5, 30, 'NZ', 'Observer', 2010, 'Epsilon');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (6, 'Frank', 6, 50, 'FR', 'Navigator', NULL, 'Zeta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM pilot WHERE (join_year < 2000 AND join_year < 2005) ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Captain',)
*/

-- Prediction Query
SELECT POSITION FROM pilot WHERE Join_Year < 2000 INTERSECT SELECT POSITION FROM pilot WHERE Join_Year > 2005;

/*
Prediction Result:
*/