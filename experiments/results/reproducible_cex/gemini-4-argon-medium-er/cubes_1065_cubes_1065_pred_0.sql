-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pilot" ("Pilot_ID", "Rank", "Age", "Join_Year") VALUES (1, 10, 50, 2000);
INSERT INTO "pilot" ("Pilot_ID", "Rank", "Age", "Join_Year") VALUES (2, 1, 30, 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT join_year FROM (SELECT * FROM (SELECT * FROM pilot ORDER BY age DESC, pilot.pilot_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(2000,)
*/

-- Prediction Query
SELECT Join_Year FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2010,)
*/