-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aircraft_id", "order_year", "manufacturer", "model", "fleet_series", "powertrain", "fuel_propulsion") VALUES (42, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "aircraft" ("aircraft_id", "order_year", "manufacturer", "model", "fleet_series", "powertrain", "fuel_propulsion") VALUES (51, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (19, '24', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (31, '24', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "pilot_record" ("pilot_id", "aircraft_id", "date", "record_id") VALUES (19, 42, '40', NULL);
INSERT INTO "pilot_record" ("pilot_id", "aircraft_id", "date", "record_id") VALUES (19, 51, '49', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name, model FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team, RHS.record_id AS record_id, RHS.date AS date FROM (SELECT LHS.aircraft_id AS aircraft_id, LHS.order_year AS order_year, LHS.manufacturer AS manufacturer, LHS.model AS model, LHS.fleet_series AS fleet_series, LHS.powertrain AS powertrain, LHS.fuel_propulsion AS fuel_propulsion, RHS.pilot_id AS pilot_id, RHS.pilot_name AS pilot_name, RHS.rank AS rank, RHS.age AS age, RHS.nationality AS nationality, RHS.position AS POSITION, RHS.join_year AS join_year, RHS.team AS team FROM aircraft AS LHS CROSS JOIN pilot AS RHS) AS LHS INNER JOIN pilot_record AS RHS ON (LHS.aircraft_id = RHS.aircraft_id AND LHS.pilot_id = RHS.pilot_id)) ORDER BY pilot_name, model NULLS LAST;

/*
Gold Result:
('24', None)
('24', None)
*/

-- Prediction Query
SELECT T3.Pilot_name, T2.Model FROM pilot_record AS T1 JOIN aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN pilot AS T3 ON T1.Pilot_ID = T3.Pilot_ID;

/*
Prediction Result:
('24', None)
('24', None)
*/