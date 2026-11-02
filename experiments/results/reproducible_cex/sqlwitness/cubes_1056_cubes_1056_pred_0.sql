-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO pilot (pilot_id, pilot_name, rank, age, nationality, position, join_year, team) VALUES (0, 'Bradley', NULL, NULL, 'Bradley', 'default1', 0, 'Fordham'), (1, 'Fordham', NULL, NULL, 'Fordham', 'default2', 1, 'default2'), (2, NULL, NULL, NULL, 'Bradley', 'Bradley', 0, 'default2'), (3, NULL, 1, NULL, 'default1', 'Fordham', 0, 'Fordham'), (4, 'default1', 0, 0, 'default2', 'Fordham', 1, NULL), (5, 'Bradley', 0, 0, 'default2', 'Bradley', 0, 'default1'), (6, 'default2', 1, 0, 'Fordham', 'default1', NULL, 'default1'), (7, 'Bradley', 0, 0, 'Fordham', 'default1', NULL, 'Bradley');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pilot_name" FROM "pilot" WHERE ("team" = 'Bradley' OR "team" = 'Fordham') ORDER BY pilot_name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
(None,)
('Bradley',)
('Bradley',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE Team = 'Bradley' OR Team = 'Fordham';

/*
Prediction Result:
('Bradley',)
(None,)
('Bradley',)
*/