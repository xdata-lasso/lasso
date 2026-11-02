-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO pilot (pilot_id, pilot_name, rank, age, nationality, position, join_year, team) VALUES (29, NULL, NULL, 30, 'default1', 'default1', 0, 'default1'), (30, 'default2', NULL, 31, NULL, 'default1', 0, 'default2'), (0, 'default2', 1, 0, NULL, 'default1', NULL, 'default1'), (1, 'default1', 31, 0, 'default1', NULL, 1, 'default1'), (31, 'default1', 30, 30, NULL, 'default1', 1, 'default1'), (2, 'default2', NULL, 0, 'default2', 'default2', NULL, 'default1'), (3, 'default2', NULL, 31, 'default1', NULL, 29, NULL), (4, NULL, 29, 0, NULL, 'default2', 30, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT POSITION FROM pilot WHERE (age > 30) ORDER BY POSITION;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT POSITION FROM pilot WHERE Age > 30;

/*
Prediction Result:
(None,)
('default1',)
*/