-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1040, 'Randy Brown', 1041, 31, 'Moldova', 'four', 1042, 'reveal');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1043, 'William Bowman', 1042, 31, 'Swaziland', 'discuss', 1043, 'support');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT POSITION FROM pilot WHERE (age > 30) ORDER BY POSITION;

/*
Gold Result:
('discuss',)
('four',)
*/

-- Prediction Query
SELECT DISTINCT POSITION FROM pilot WHERE Age > 30;

/*
Prediction Result:
('four',)
('discuss',)
*/