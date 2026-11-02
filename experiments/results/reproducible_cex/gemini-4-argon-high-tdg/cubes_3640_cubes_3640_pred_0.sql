-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (1, 2010, 'Boeing', '737', 'FS-33', 'Turbofan', 'Jet-A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (2, 2012, 'Airbus', 'A320', 'FS-34', 'CFM56', 'Kerosene');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (3, 2014, 'Embraer', 'E190', 'FS-35', 'GE-CF34', 'Biofuel');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (4, 2016, 'Bombardier', 'CRJ900', 'FS-NULL', 'Turbojet', 'Avgas');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (5, 2018, 'Cessna', 'Citation', 'FS-25', 'Pratt', 'Jet-A1');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Alice', 50, 33, 'USA', 'Captain', 2015, 'Red');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'Bob', 10, 34, 'UK', 'First Officer', 2012, 'Blue');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (3, 'Charlie', 5, 35, 'Canada', 'Captain', 2010, 'Green');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (4, 'Diana', 1, NULL, 'France', 'Cadet', 2020, 'Yellow');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (5, 'Evan', 40, 25, 'Germany', 'First Officer', 2019, 'White');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 1, '2023-05-01', 101);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (2, 2, '2023-05-02', 102);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (3, 3, '2023-05-03', 103);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (4, 4, '2023-05-04', 104);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (5, 5, '2023-05-05', 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fleet_series FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, LHS.record_id AS record_id, LHS.pilot_id AS pilot_id, LHS.date AS date, RHS.pilot_name AS pilot_name, RHS.rank AS rank, RHS.age AS age, RHS.nationality AS nationality, RHS.position AS POSITION, RHS.join_year AS join_year, RHS.team AS team FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, RHS.record_id AS record_id, RHS.pilot_id AS pilot_id, RHS.date AS date FROM aircraft AS LHS INNER JOIN pilot_record AS RHS ON (LHS.aircraft_id = RHS.aircraft_id)) AS LHS INNER JOIN (SELECT * FROM pilot WHERE (age < 34)) AS RHS ON (LHS.pilot_id = RHS.pilot_id)) ORDER BY fleet_series;

/*
Gold Result:
('FS-25',)
('FS-33',)
*/

-- Prediction Query
SELECT T2.Fleet_Series FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID = T3.Pilot_ID WHERE T3.Age < 34;

/*
Prediction Result:
('FS-33',)
('FS-25',)
*/