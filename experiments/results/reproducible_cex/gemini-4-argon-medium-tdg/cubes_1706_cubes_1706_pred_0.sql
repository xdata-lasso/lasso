-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column order, column selection, ordering direction (ASC vs DESC vs insertion order vs other columns), and JOIN/subquery mutants (an airport with 0 flights vs an airport with 2 flights).
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (30, 'Atlanta', 'USA', 'ATL', 'KATL', 'Hartsfield-Jackson');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (10, 'Zurich', 'Switzerland', 'ZRH', 'LSZH', 'Zurich Airport');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (20, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'Delta', 'Airline', 'Passenger', 'USA', 100.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (101, 1, 10, 'DL100', '2023-01-01', 'Smith', 500.0, 35000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (102, 1, 10, 'DL101', '2023-01-02', 'Jones', 520.0, 36000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, country, city, name FROM airport ORDER BY id;

/*
Gold Result:
(10, 'Switzerland', 'Zurich', 'Zurich Airport')
(20, 'UK', 'London', 'Heathrow')
(30, 'USA', 'Atlanta', 'Hartsfield-Jackson')
*/

-- Prediction Query
SELECT id, country, city, name FROM airport ORDER BY name, airport.id NULLS LAST;

/*
Prediction Result:
(30, 'USA', 'Atlanta', 'Hartsfield-Jackson')
(20, 'UK', 'London', 'Heathrow')
(10, 'Switzerland', 'Zurich', 'Zurich Airport')
*/