-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (1, 1995, 'Boeing', '737', 'Series_B', 'Jet', 'Jet_A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (2, 2005, 'Airbus', 'A320', 'Series_A', 'Turboprop', 'Biofuel');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (3, 2010, 'Boeing', '747', NULL, 'Jet', 'Jet_A');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (4, 2020, 'Embraer', 'E190', 'Series_C', 'Electric', 'Battery');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Bravo', 1, 25, 'USA', 'Captain', 2015, 'Red');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'Alpha', 2, 40, 'UK', 'First Officer', 2008, 'Blue');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (3, NULL, 3, 35, 'Canada', 'Captain', 2012, 'Green');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (4, 'Delta', 4, 50, 'France', 'Commander', 1998, 'Yellow');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 1, '2021-01-01', 101);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 1, '2021-01-02', 102);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 2, '2021-01-03', 103);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 3, '2021-01-04', 104);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (2, 2, '2021-01-05', 105);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (3, 1, '2021-01-06', 106);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name, fleet_series FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team, RHS.record_id AS record_id, RHS.date AS date FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, RHS.pilot_id AS pilot_id, RHS.pilot_name AS pilot_name, RHS.rank AS rank, RHS.age AS age, RHS.nationality AS nationality, RHS.position AS POSITION, RHS.join_year AS join_year, RHS.team AS team FROM aircraft AS LHS CROSS JOIN pilot AS RHS) AS LHS INNER JOIN pilot_record AS RHS ON (LHS.aircraft_id = RHS.aircraft_id AND LHS.pilot_id = RHS.pilot_id)) ORDER BY pilot_name, fleet_series NULLS LAST;

/*
Gold Result:
(None, 'Series_B')
('Alpha', 'Series_A')
('Bravo', 'Series_A')
('Bravo', 'Series_B')
('Bravo', 'Series_B')
('Bravo', None)
*/

-- Prediction Query
SELECT T3.Pilot_name, T2.Fleet_Series FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID = T3.Pilot_ID ORDER BY T3.Rank, T1.pilot_id NULLS LAST, T1.aircraft_id NULLS LAST, T1.date NULLS LAST, T2.aircraft_id NULLS LAST, T3.pilot_id NULLS LAST;

/*
Prediction Result:
('Bravo', 'Series_B')
('Bravo', 'Series_B')
('Bravo', 'Series_A')
('Bravo', None)
('Alpha', 'Series_A')
(None, 'Series_B')
*/