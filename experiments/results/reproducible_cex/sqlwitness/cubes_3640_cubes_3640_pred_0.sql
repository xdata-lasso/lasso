-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO pilot (pilot_id, pilot_name, rank, age, nationality, position, join_year, team) VALUES (1, 'default1', 35, NULL, 'default1', 'default2', 1, 'default1'), (35, 'default1', 34, 33, NULL, 'default2', NULL, 'default2'), (0, 'default1', 0, 35, 'default2', 'default2', 33, 'default2'), (34, NULL, 33, 34, NULL, 'default2', 1, NULL), (33, NULL, 34, 33, NULL, NULL, 1, NULL), (2, NULL, 0, NULL, 'default2', 'default2', 35, 'default2'), (3, NULL, 1, 35, 'default1', NULL, 1, 'default2');
INSERT INTO aircraft (aircraft_id, order_year, manufacturer, model, fleet_series, powertrain, fuel_propulsion) VALUES (0, 34, NULL, NULL, NULL, 'default2', 'default1'), (34, NULL, 'default2', 'default2', 'default1', NULL, 'default2'), (1, 1, NULL, 'default2', 'default1', 'default1', 'default2'), (33, 1, 'default2', NULL, 'default1', NULL, 'default1'), (35, 35, 'default2', NULL, 'default1', 'default2', 'default1'), (2, 34, 'default1', NULL, NULL, 'default2', NULL), (3, 35, 'default2', 'default1', 'default2', 'default2', 'default2');
INSERT INTO pilot_record (pilot_id, aircraft_id, date, record_id) VALUES (3, 0, 'default2', 35), (35, 2, 'default1', 35), (33, 33, 'default2', 0), (0, 34, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fleet_series FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, LHS.record_id AS record_id, LHS.pilot_id AS pilot_id, LHS.date AS date, RHS.pilot_name AS pilot_name, RHS.rank AS rank, RHS.age AS age, RHS.nationality AS nationality, RHS.position AS POSITION, RHS.join_year AS join_year, RHS.team AS team FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, RHS.record_id AS record_id, RHS.pilot_id AS pilot_id, RHS.date AS date FROM aircraft AS LHS INNER JOIN pilot_record AS RHS ON (LHS.aircraft_id = RHS.aircraft_id)) AS LHS INNER JOIN (SELECT * FROM pilot WHERE (age < 34)) AS RHS ON (LHS.pilot_id = RHS.pilot_id)) ORDER BY fleet_series;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T2.Fleet_Series FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID = T3.Pilot_ID WHERE T3.Age < 34;

/*
Prediction Result:
('default1',)
(None,)
*/