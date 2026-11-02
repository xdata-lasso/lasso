-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (21, '27', '28', '29', '30', NULL);
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (20, NULL, NULL, NULL, NULL, '31');
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (20, NULL, '41', '42', NULL, NULL);
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (57, '51', NULL, NULL, '54', 55);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (45, 20, 20, '46', '47', '48', NULL, NULL);
INSERT INTO "flight" ("id", "company_id", "airport_id", "vehicle_flight_number", "date", "pilot", "velocity", "altitude") VALUES (56, 57, 21, NULL, '59', NULL, 61, 62);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airport_id AS id, n AS count___ FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.airport_id AS airport_id, RHS.n AS n FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, RHS.type AS TYPE, RHS.principal_activities AS principal_activities, RHS.incorporated_in AS incorporated_in, RHS.group_equity_shareholding AS group_equity_shareholding FROM airport AS LHS INNER JOIN operate_company AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name)) AS LHS CROSS JOIN (SELECT airport_id, COUNT(*) AS n FROM flight GROUP BY airport_id) AS RHS) ORDER BY id, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.id, COUNT(*) FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id JOIN airport AS T3 ON T2.airport_id = T3.id GROUP BY T3.id;

/*
Prediction Result:
(20, 1)
(21, 1)
*/