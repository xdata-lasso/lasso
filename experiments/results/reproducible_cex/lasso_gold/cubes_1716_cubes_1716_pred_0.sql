-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1035, 'Lake Anna', 'Estonia', 'skin', 'pattern', 'Kevin Cox');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1047, 'West Ryanmouth', 'Afghanistan', 'seven', 'type', 'Valerie Gill');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1041, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1036, 'Brenda Snyder PhD', 'traditional', 'break', 'claim', 1037.5);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1048, 'Ashley Garrett', 'thought', 'purpose', 'movement', 1049.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1038, 1036, 1035, 'product', 'collection', 'structure', 1039.5, 1040.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1044, 1036, 1041, 'specific', 'put', 'grow', 1045.5, 1046.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (1050, 1048, 1047, 'politics', 'decide', 'hour', 1051.5, 1052.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TYPE FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.id AS id_other, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity, RHS.altitude AS altitude, RHS.airport_id AS airport_id FROM operate_company AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY name, TYPE NULLS LAST;

/*
Gold Result:
('Ashley Garrett', 'thought')
('Brenda Snyder PhD', 'traditional')
('Brenda Snyder PhD', 'traditional')
*/

-- Prediction Query
SELECT T1.name, T1.type FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id;

/*
Prediction Result:
('Brenda Snyder PhD', 'traditional')
('Brenda Snyder PhD', 'traditional')
('Ashley Garrett', 'thought')
*/