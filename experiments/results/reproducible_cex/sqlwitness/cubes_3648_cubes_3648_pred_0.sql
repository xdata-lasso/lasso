-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO pilot (pilot_id, pilot_name, rank, age, nationality, position, join_year, team) VALUES (0, NULL, 0, NULL, 'default2', NULL, NULL, NULL), (1, 'default1', NULL, NULL, 'default1', 'default1', NULL, 'default2'), (2, 'default1', 1, NULL, NULL, NULL, 1, NULL), (3, 'default2', 0, 1, 'default2', NULL, 1, NULL), (4, 'default2', 0, 0, 'default1', 'default2', 0, NULL), (5, 'default2', NULL, 1, NULL, 'default2', 0, NULL), (6, 'default1', 0, 1, NULL, 'default1', 0, 'default1'), (7, 'default2', 1, NULL, 'default2', NULL, 0, 'default2'), (8, NULL, NULL, 0, 'default1', 'default1', 1, 'default2'), (9, NULL, NULL, NULL, NULL, NULL, 1, 'default1');
INSERT INTO aircraft (aircraft_id, order_year, manufacturer, model, fleet_series, powertrain, fuel_propulsion) VALUES (1, NULL, 'default1', 'default2', 'default1', 'default2', 'default2'), (0, NULL, 'default1', 'default1', 'default1', 'default1', 'default2'), (2, 0, 'default2', 'default2', 'default1', 'default2', NULL), (3, NULL, NULL, NULL, 'default2', 'default2', 'default2'), (4, 0, NULL, NULL, 'default1', NULL, 'default1');
INSERT INTO pilot_record (pilot_id, aircraft_id, date, record_id) VALUES (9, 2, 'default1', 0), (7, 0, 'default1', 0), (1, 4, 'default1', 1), (3, 3, 'default1', NULL), (1, 1, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name, model FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team, RHS.record_id AS record_id, RHS.date AS date FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, RHS.pilot_id AS pilot_id, RHS.pilot_name AS pilot_name, RHS.rank AS rank, RHS.age AS age, RHS.nationality AS nationality, RHS.position AS POSITION, RHS.join_year AS join_year, RHS.team AS team FROM aircraft AS LHS CROSS JOIN pilot AS RHS) AS LHS INNER JOIN pilot_record AS RHS ON (LHS.aircraft_id = RHS.aircraft_id AND LHS.pilot_id = RHS.pilot_id)) ORDER BY pilot_name, model NULLS LAST;

/*
Gold Result:
(None, 'default2')
('default1', 'default2')
('default1', None)
('default2', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT T3.Pilot_name, T2.Model FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID = T3.Pilot_ID;

/*
Prediction Result:
('default1', 'default2')
('default1', None)
('default2', None)
('default2', 'default1')
(None, 'default2')
*/