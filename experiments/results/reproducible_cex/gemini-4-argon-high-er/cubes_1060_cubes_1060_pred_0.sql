-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (1, 2000, 'Boeing', '747', '100', 'Jet', 'JetA');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'B', 1, 30, 'US', 'Captain', 2010, 'Red');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'A', 2, 25, 'UK', 'First Officer', 2015, 'Blue');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (NULL, 1, '2020-01-01', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM (SELECT * FROM pilot AS LHS WHERE NOT EXISTS(SELECT 1 FROM pilot_record AS RHS WHERE (LHS.pilot_id = RHS.pilot_id))) ORDER BY pilot_name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE NOT Pilot_ID IN (SELECT Pilot_ID FROM pilot_record);

/*
Prediction Result:
*/