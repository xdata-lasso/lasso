-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO pilot (pilot_id, pilot_name, rank, age, nationality, position, join_year, team) VALUES (0, NULL, 1, 0, 'default1', 'default1', 1, 'default1'), (1, NULL, NULL, 1, 'default2', 'default1', 1, NULL), (2, 'default1', 0, 0, NULL, NULL, NULL, 'default1'), (3, NULL, NULL, 1, 'default1', 'default2', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION, team FROM pilot ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default1')
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT POSITION, Team FROM pilot;

/*
Prediction Result:
('default1', 'default1')
('default1', None)
(None, 'default1')
('default2', None)
*/