-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (101, 1995, 'Boeing', '737', 'B737-800', 'Turbofan', 'Jet A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (102, 2003, 'Airbus', 'A320', 'A320-200', 'Turbofan', 'Jet A');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Alice Smith', 1, 55, 'USA', 'Senior Captain', 1995, 'Alpha');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'Bob Jones', 2, 50, 'UK', 'Captain', 1999, 'Beta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (3, 'Charlie Brown', 3, 48, 'Canada', 'Captain', 1998, 'Gamma');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (4, 'Diana Prince', 4, 45, 'USA', 'First Officer', 1990, 'Delta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (5, 'Evan Wright', 5, 42, 'Australia', 'Second Officer', 2000, 'Epsilon');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (6, 'Fiona Gallagher', 6, 39, 'Ireland', 'Relief Pilot', 2002, 'Zeta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (7, 'George Clark', 7, 36, 'UK', 'Cadet', 2005, 'Eta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (8, 'Hannah Abbott', 8, 30, 'Canada', 'Trainee', 2010, 'Theta');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (9, 'Ian Malcolm', 9, 40, 'USA', 'Instructor', NULL, 'Iota');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 101, '2015-01-10', 1001);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 102, '2016-05-20', 1002);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (2, 101, '2017-03-15', 1003);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (6, 101, '2018-07-22', 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM pilot WHERE (join_year < 2000 AND join_year < 2005) ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Captain',)
('Captain',)
('First Officer',)
('Senior Captain',)
*/

-- Prediction Query
SELECT POSITION FROM pilot WHERE Join_Year < 2000 INTERSECT SELECT POSITION FROM pilot WHERE Join_Year > 2005;

/*
Prediction Result:
*/