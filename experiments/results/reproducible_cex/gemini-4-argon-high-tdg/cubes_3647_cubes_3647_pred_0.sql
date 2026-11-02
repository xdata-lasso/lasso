-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (10, 2012, 'Boeing', '777', 'Fleet-777', 'Jet', 'Kerosene');
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (20, 2016, 'Airbus', 'A350', 'Fleet-350', 'Jet', 'Kerosene');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Diana', 5, 40, 'France', 'Captain', 2008, 'Alpha');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 10, '2023-01-01', 501);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 10, '2023-01-02', 502);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 10, '2023-01-03', 503);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 20, '2023-02-01', 504);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name, fleet_series FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team, RHS.record_id AS record_id, RHS.date AS date FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, RHS.pilot_id AS pilot_id, RHS.pilot_name AS pilot_name, RHS.rank AS rank, RHS.age AS age, RHS.nationality AS nationality, RHS.position AS POSITION, RHS.join_year AS join_year, RHS.team AS team FROM aircraft AS LHS CROSS JOIN pilot AS RHS) AS LHS INNER JOIN pilot_record AS RHS ON (LHS.aircraft_id = RHS.aircraft_id AND LHS.pilot_id = RHS.pilot_id)) ORDER BY pilot_name, fleet_series NULLS LAST;

/*
Gold Result:
('Diana', 'Fleet-350')
('Diana', 'Fleet-777')
('Diana', 'Fleet-777')
('Diana', 'Fleet-777')
*/

-- Prediction Query
SELECT T3.Pilot_name, T2.Fleet_Series FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID = T3.Pilot_ID ORDER BY T3.Rank, T1.pilot_id NULLS LAST, T1.aircraft_id NULLS LAST, T1.date NULLS LAST, T2.aircraft_id NULLS LAST, T3.pilot_id NULLS LAST;

/*
Prediction Result:
('Diana', 'Fleet-777')
('Diana', 'Fleet-777')
('Diana', 'Fleet-777')
('Diana', 'Fleet-350')
*/