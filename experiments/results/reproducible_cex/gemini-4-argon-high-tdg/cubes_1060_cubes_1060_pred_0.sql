-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (1, 2015, 'Boeing', '737-800', '737NG', 'CFM56', 'Jet-A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (2, 2018, 'Airbus', 'A320neo', 'A320', 'LEAP-1A', 'Jet-A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (3, 2020, 'Boeing', '787-9', '787', 'GEnx', 'Jet-A');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Zachary', 1, 25, 'USA', 'First Officer', 2018, 'Alpha');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'Alice', 3, 40, 'UK', 'Captain', 2022, 'Charlie');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (3, 'Mason', 2, 30, 'Canada', 'First Officer', 2020, 'Bravo');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (4, 'Bob', 4, 35, 'USA', 'Captain', 2019, 'Delta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (5, 'Charlie', 5, 45, 'Australia', 'Captain', 2015, 'Echo');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (4, 1, '2023-01-10', 1);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (5, 2, '2023-02-15', 2);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (5, 3, '2023-03-20', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM (SELECT * FROM pilot AS LHS WHERE NOT EXISTS(SELECT 1 FROM pilot_record AS RHS WHERE (LHS.pilot_id = RHS.pilot_id))) ORDER BY pilot_name;

/*
Gold Result:
('Alice',)
('Mason',)
('Zachary',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE NOT Pilot_ID IN (SELECT Pilot_ID FROM pilot_record);

/*
Prediction Result:
('Zachary',)
('Alice',)
('Mason',)
*/