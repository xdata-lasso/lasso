-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests tie-breaking on max Age (using Pilot_ID ASC) and detects incorrect MIN/MAX(join_year), LIMIT omission, or INNER JOIN with pilot_record.
INSERT INTO "aircraft" ("Aircraft_ID", "Order_Year", "Manufacturer", "Model", "Fleet_Series", "Powertrain", "Fuel_Propulsion") VALUES (1, 2005, 'Boeing', '747', 'F1', 'Jet', 'Fuel');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (10, 'Alice', 3, 55, 'USA', 'Captain', 2010, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (20, 'Bob', 1, 55, 'UK', 'First Officer', 2015, 'Beta');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (5, 'Charlie', 2, 40, 'Canada', 'Captain', 2000, 'Gamma');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (30, 'Diana', 4, 30, 'USA', 'Cadet', 2022, 'Delta');
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (20, 1, '2021-01-01', 101);
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (5, 1, '2021-02-01', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT join_year FROM (SELECT * FROM (SELECT * FROM pilot ORDER BY age DESC, pilot.pilot_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(2010,)
*/

-- Prediction Query
SELECT Join_Year FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2015,)
*/