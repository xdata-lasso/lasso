-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set when no rows match WHERE ("pilot" = 'Thompson').
-- Distinguishes window function (returns 0 rows) from standard aggregate AVG() without GROUP BY (returns 1 row with NULL).
-- Also tests case-sensitivity ('thompson') and substring matching ('Thompson Jr.').
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'New York', 'USA', 'JFK', 'KJFK', 'Kennedy');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'JetWays', 'Commercial', 'Flights', 'USA', 50.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 1, 'J1', '2023-02-01', 'Smith', 400.0, 15000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'J2', '2023-02-02', 'thompson', 500.0, 16000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (3, 1, 1, 'J3', '2023-02-03', 'Thompson Jr.', 600.0, 17000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (4, 1, 1, 'J4', '2023-02-04', NULL, 700.0, 18000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG("velocity") OVER () AS "avg_velocity_" FROM "flight" WHERE ("pilot" = 'Thompson') ORDER BY avg_velocity_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(velocity) FROM flight WHERE pilot = 'Thompson';

/*
Prediction Result:
(None,)
*/