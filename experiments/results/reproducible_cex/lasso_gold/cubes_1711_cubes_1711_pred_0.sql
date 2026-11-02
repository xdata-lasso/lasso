-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1001, 'North Judithbury', 'Bermuda', 'mouth', 'option', 'Kimberly Robinson');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1002, 'East Jill', 'Cuba', 'play', 'decide', 'Rhonda Smith');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1003, 'New Roberttown', 'Djibouti', 'agreement', 'sense', 'Melissa Peterson');
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1004, 'Tyler Rogers', 'not', 'human', 'finally', 1007.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1005, 'Brent Abbott', 'capital', 'bar', 'themselves', 1020.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1006, 'Renee Blair', 'win', 'old', 'production', 1033.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1010, 1004, 1001, 'present', 'high', 'sea', 200.0, 1013.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1011, 1004, 1001, 'value', 'participant', 'available', 200.0, 1013.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1012, 1004, 1001, 'training', 'dark', 'answer', 200.0, 1013.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT altitude, velocity, COUNT(*) AS n FROM flight GROUP BY altitude, velocity) WHERE (n <> 200 AND velocity >= 200.0) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM flight WHERE velocity > 200;

/*
Prediction Result:
(0,)
*/