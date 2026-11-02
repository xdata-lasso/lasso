-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (101, 2015, 'Boeing', '737-800', 'B737', 'Turbofan', 'Jet-A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (102, 2018, 'Airbus', 'A320neo', 'A320', 'Turbofan', 'Jet-A');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (10, 'Zack Miller', 3, 45, 'USA', 'Commander', 2010, 'Delta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (20, 'Alice Smith', 1, 30, 'UK', 'Commander', 2018, 'Alpha');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (30, 'Bob Jones', 2, 38, 'Canada', 'Commander', 2014, 'Charlie');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (5, 'Charlie Brown', 4, 50, 'USA', 'Trainee', 2022, 'Bravo');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (15, 'Diana Prince', 5, 29, 'France', 'Captain', 2019, 'Echo');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (25, 'Evan Wright', 2, 41, 'Germany', 'Captain', 2012, 'Echo');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (10, 101, '2023-01-10', 1001);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (10, 102, '2023-02-15', 1002);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (20, 101, '2023-03-20', 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION, team FROM pilot ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Captain', 'Echo')
('Captain', 'Echo')
('Commander', 'Delta')
('Commander', 'Alpha')
('Commander', 'Charlie')
('Trainee', 'Bravo')
*/

-- Prediction Query
SELECT POSITION, Team FROM pilot;

/*
Prediction Result:
('Trainee', 'Bravo')
('Commander', 'Delta')
('Captain', 'Echo')
('Commander', 'Alpha')
('Captain', 'Echo')
('Commander', 'Charlie')
*/