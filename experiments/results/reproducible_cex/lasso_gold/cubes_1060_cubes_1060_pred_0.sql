-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1028, 'Joe Martinez', 1029, 1030, 'Tokelau', 'high', 1031, 'bar');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1032, 'Benjamin Stanley', 1030, 1031, 'Uzbekistan', 'human', 1032, 'participant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM (SELECT * FROM pilot AS LHS WHERE NOT EXISTS(SELECT 1 FROM pilot_record AS RHS WHERE (LHS.pilot_id = RHS.pilot_id))) ORDER BY pilot_name;

/*
Gold Result:
('Benjamin Stanley',)
('Joe Martinez',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot WHERE NOT Pilot_ID IN (SELECT Pilot_ID FROM pilot_record);

/*
Prediction Result:
('Joe Martinez',)
('Benjamin Stanley',)
*/