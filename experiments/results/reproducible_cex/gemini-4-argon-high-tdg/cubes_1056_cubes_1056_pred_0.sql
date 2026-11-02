-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("Aircraft_ID", "Order_Year", "Manufacturer", "Model", "Fleet_Series", "Powertrain", "Fuel_Propulsion") VALUES (101, 2015, 'Boeing', '737-800', 'Series A', 'Turbofan', 'Jet A');
INSERT INTO "aircraft" ("Aircraft_ID", "Order_Year", "Manufacturer", "Model", "Fleet_Series", "Powertrain", "Fuel_Propulsion") VALUES (102, 2018, 'Airbus', 'A320neo', 'Series B', 'Turbofan', 'Jet A-1');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (1, 'Zack Taylor', 1, 28, 'USA', 'First Officer', 2016, 'Bradley');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (2, 'Mia Wallace', 2, 34, 'Canada', 'Captain', 2017, 'Fordham');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (3, 'Aaron Burr', 3, 45, 'USA', 'Commander', 2019, 'Bradley');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (4, 'Liam Neeson', 1, 50, 'UK', 'Captain', 2010, 'Stanford');
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank", "Age", "Nationality", "Position", "Join_Year", "Team") VALUES (5, 'Emma Stone', 4, 31, 'USA', 'Navigator', 2020, 'Yale');
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (2, 101, '2022-01-15', 1001);
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (2, 102, '2022-03-20', 1002);
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (3, 101, '2022-05-10', 1003);
INSERT INTO "pilot_record" ("Pilot_ID", "Aircraft_ID", "Date", "Record_ID") VALUES (4, 102, '2022-06-11', 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pilot_name" FROM "pilot" WHERE ("team" = 'Bradley' OR "team" = 'Fordham') ORDER BY pilot_name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Aaron Burr',)
('Mia Wallace',)
('Zack Taylor',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE Team = 'Bradley' OR Team = 'Fordham';

/*
Prediction Result:
('Zack Taylor',)
('Mia Wallace',)
('Aaron Burr',)
*/