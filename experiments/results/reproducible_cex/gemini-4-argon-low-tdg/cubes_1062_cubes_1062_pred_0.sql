-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-correlation between Pilot_ID and Pilot_name, duplicates (to kill DISTINCT/GROUP BY mutants), and Pilots without pilot_records (to kill INNER JOIN mutants).
INSERT INTO "aircraft" ("Aircraft_ID", "Order_Year", "Manufacturer", "Model", "Fleet_Series", "Powertrain", "Fuel_Propulsion") VALUES (1, 2015, 'Boeing', '737', 'A', 'Jet', 'Kerosene');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (1, 'Zack', 3, 25, 'USA', 'Captain', 2020, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (2, 'Alice', 1, 45, 'UK', 'First Officer', 2010, 'Beta');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (3, 'Alice', 2, 35, 'Canada', 'Captain', 2015, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (4, 'Bob', 4, 30, 'USA', 'Cadet', 2018, 'Gamma');
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (1, 1, '2021-01-01', 101);
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (1, 1, '2021-01-02', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM pilot ORDER BY pilot_name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Alice',)
('Zack',)
('Bob',)
*/