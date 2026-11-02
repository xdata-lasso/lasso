-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE boundaries (< 2000 vs = 2000 vs between 2000 and 2005 vs >= 2005),
-- ORDER BY Position ASC vs DESC, and DISTINCT vs ALL (duplicate Positions).
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (1, 'John Doe', 1, 45, 'USA', 'Captain', 1999, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (2, 'Jane Smith', 2, 40, 'UK', 'First Officer', 1995, 'Bravo');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (3, 'Bob Brown', 1, 50, 'Canada', 'Captain', 1990, 'Alpha');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (4, 'Alice White', 3, 35, 'USA', 'Navigator', 2000, 'Charlie');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (5, 'Charlie Black', 2, 38, 'Australia', 'Engineer', 2003, 'Bravo');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (6, 'Eva Green', 3, 30, 'UK', 'Cadet', 2005, 'Delta');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (7, 'Frank Blue', 4, 28, 'USA', 'Trainee', 2010, 'Delta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM pilot WHERE (join_year < 2000 AND join_year < 2005) ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Captain',)
('Captain',)
('First Officer',)
*/

-- Prediction Query
SELECT POSITION FROM pilot WHERE Join_Year < 2000 INTERSECT SELECT POSITION FROM pilot WHERE Join_Year > 2005;

/*
Prediction Result:
*/