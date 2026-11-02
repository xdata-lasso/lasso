-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank") VALUES (1, 'Alice', 2);
INSERT INTO "pilot" ("Pilot_ID", "Pilot_name", "Rank") VALUES (2, 'Bob', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pilot_name FROM pilot ORDER BY pilot_name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Pilot_name FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
*/