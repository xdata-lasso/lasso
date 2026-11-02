-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'TestCity', 'TestCountry', 'TST', 'TEST', 'Test Airport');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'TestComp', 'Airline', 'Flights', 'USA', 100.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 1, 'A', '2023-01-01', 'Pilot1', 500.0, 200.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'B', '2023-01-02', 'Pilot2', 500.0, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY vehicle_flight_number, flight.id NULLS LAST;

/*
Gold Result:
('A', '2023-01-01', 'Pilot1')
('B', '2023-01-02', 'Pilot2')
*/

-- Prediction Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY altitude ASC, flight.id NULLS LAST;

/*
Prediction Result:
('B', '2023-01-02', 'Pilot2')
('A', '2023-01-01', 'Pilot1')
*/