-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'New York', 'USA', 'JFK', 'KJFK', 'John F. Kennedy International Airport');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'CargoAir', 'Logistics', 'Cargo', 'USA', 100.0);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (2, 'CaterAir', 'Services', 'Catering services', 'UK', 50.0);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (3, 'PassAir', 'Commercial', 'Passenger', 'France', 75.5);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (4, 'NullAir', 'Unknown', NULL, 'Germany', 0.0);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (5, 'CargoLower', 'Logistics', 'cargo', 'Canada', 80.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (101, 1, 1, 'CA100', '2023-01-01', 'Zane', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (102, 1, 1, 'CA101', '2023-01-02', 'Alice', 510.0, 31000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (103, 1, 1, 'CA102', '2023-01-03', 'Alice', 520.0, 32000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (104, 1, 1, 'CA103', '2023-01-04', NULL, 490.0, 29000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (105, 2, 1, 'CT200', '2023-01-05', 'Bob', 450.0, 25000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (106, 3, 1, 'PA300', '2023-01-06', 'Charlie', 600.0, 35000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (107, 4, 1, 'NA400', '2023-01-07', 'Dave', 480.0, 28000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (108, 5, 1, 'CL500', '2023-01-08', 'Eve', 505.0, 30500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pilot" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."type" AS "type", "LHS"."principal_activities" AS "principal_activities", "LHS"."incorporated_in" AS "incorporated_in", "LHS"."group_equity_shareholding" AS "group_equity_shareholding", "RHS"."id" AS "id_other", "RHS"."vehicle_flight_number" AS "vehicle_flight_number", "RHS"."date" AS "date", "RHS"."pilot" AS "pilot", "RHS"."velocity" AS "velocity", "RHS"."altitude" AS "altitude", "RHS"."airport_id" AS "airport_id" FROM (SELECT * FROM "operate_company" WHERE ("principal_activities" = 'Cargo' AND "principal_activities" <> 'Catering services')) AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY pilot, "pilot" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Zane',)
*/

-- Prediction Query
SELECT T2.pilot FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T1.principal_activities = 'Cargo' INTERSECT SELECT T2.pilot FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T1.principal_activities = 'Catering services';

/*
Prediction Result:
*/