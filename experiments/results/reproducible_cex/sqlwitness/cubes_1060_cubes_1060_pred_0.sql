-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO pilot (pilot_id, pilot_name, rank, age, nationality, position, join_year, team) VALUES (1, 'default1', NULL, 2, NULL, NULL, 2, 'default2'), (0, 'default1', 2, 0, 'default1', 'default2', 1, 'default2'), (2, NULL, NULL, 2, NULL, 'default2', 2, NULL), (3, NULL, 2, 2, NULL, 'default2', 0, 'default2'), (4, NULL, 1, 1, 'default2', NULL, 2, NULL);
INSERT INTO aircraft (aircraft_id, order_year, manufacturer, model, fleet_series, powertrain, fuel_propulsion) VALUES (2, 1, NULL, 'default2', NULL, NULL, 'default1');
INSERT INTO pilot_record (pilot_id, aircraft_id, date, record_id) VALUES (4, 2, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM (SELECT * FROM pilot AS LHS WHERE NOT EXISTS(SELECT 1 FROM pilot_record AS RHS WHERE (LHS.pilot_id = RHS.pilot_id))) ORDER BY pilot_name;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE NOT Pilot_ID IN (SELECT Pilot_ID FROM pilot_record);

/*
Prediction Result:
('default1',)
('default1',)
(None,)
(None,)
*/