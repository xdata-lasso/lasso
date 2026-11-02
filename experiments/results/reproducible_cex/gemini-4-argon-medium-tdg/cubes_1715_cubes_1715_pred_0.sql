-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'Billund', 'United States', 'BLL', 'EKBI', 'Billund Airport');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'Chicago', 'United States', 'ORD', 'KORD', 'O Hare');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (3, 'Billund', 'Denmark', 'BLL', 'EKBI', 'Billund Airport');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (4, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'AirCorp', 'Commercial', 'Flights', 'USA', 100.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 4, 'F100', '2023-01-01', 'Pilot_Both_Excluded', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'F101', '2023-01-02', 'Pilot_US_Not_Billund', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (3, 1, 1, 'F102', '2023-01-03', 'Pilot_Denmark_Billund', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (4, 1, 1, 'F103', '2023-01-04', 'Pilot_UK_Heathrow', 500.0, 30000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "pilot" FROM (SELECT "LHS"."id" AS "id", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."name" AS "name", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id", "RHS"."company_id" AS "company_id" FROM "airport" AS "LHS" INNER JOIN "flight" AS "RHS" ON ("LHS"."id" = "RHS"."id")) WHERE ("country" <> 'United States' OR "name" <> 'Billund Airport') ORDER BY pilot, "pilot" NULLS LAST;

/*
Gold Result:
('Pilot_Denmark_Billund',)
('Pilot_UK_Heathrow',)
('Pilot_US_Not_Billund',)
*/

-- Prediction Query
SELECT DISTINCT T2.pilot FROM airport AS T1 JOIN flight AS T2 ON T1.id = T2.airport_id WHERE T1.country = 'United States' OR T1.name = 'Billund Airport';

/*
Prediction Result:
('Pilot_US_Not_Billund',)
('Pilot_Denmark_Billund',)
('Pilot_UK_Heathrow',)
*/