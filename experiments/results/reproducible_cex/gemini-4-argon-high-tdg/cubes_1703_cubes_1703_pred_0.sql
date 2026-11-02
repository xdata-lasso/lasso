-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'Berlin', 'Germany', 'BER', 'EDDB', 'Brandenburg');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'EuroJet', 'Commercial', 'Airline', 'Germany', 75.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 1, 'EJ01', '2023-02-01', 'Jones', 450.0, 33000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'EJ02', '2023-02-02', NULL, 500.0, 34000.0);
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