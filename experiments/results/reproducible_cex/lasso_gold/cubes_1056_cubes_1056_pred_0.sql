-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1053, 'Michael Miles', 1055, 1057, 'Martinique', 'election', 1059, 'Bradley');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1054, 'Andrea Reid', 1062.0, 1066.0, 'Saint Lucia', 'common', 1074.0, 'Fordham');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1061, 'Devin Schaefer', 1063, 1065, 'Seychelles', 'arrive', 1067, 'Bradley');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1062, 'Colleen Nguyen', 1070.0, 1074.0, 'Singapore', 'drop', 1082.0, 'Fordham');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pilot_name" FROM "pilot" WHERE ("team" = 'Bradley' OR "team" = 'Fordham') ORDER BY pilot_name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Andrea Reid',)
('Colleen Nguyen',)
('Devin Schaefer',)
('Michael Miles',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE Team = 'Bradley' OR Team = 'Fordham';

/*
Prediction Result:
('Michael Miles',)
('Andrea Reid',)
('Devin Schaefer',)
('Colleen Nguyen',)
*/