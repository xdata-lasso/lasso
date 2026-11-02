-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'AirCorp', 'Commercial', 'Aviation', 'UK', 100.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (10, 1, 1, 'FL200', '2023-05-01', 'Smith', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (20, 1, 1, 'FL100', '2023-06-01', 'Jones', 550.0, 32000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (5, 1, 1, 'FL100', '2023-07-01', 'Taylor', 520.0, 31000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY vehicle_flight_number, flight.id NULLS LAST;

/*
Gold Result:
('FL100', '2023-07-01', 'Taylor')
('FL100', '2023-06-01', 'Jones')
('FL200', '2023-05-01', 'Smith')
*/

-- Prediction Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY altitude ASC, flight.id NULLS LAST;

/*
Prediction Result:
('FL200', '2023-05-01', 'Smith')
('FL100', '2023-07-01', 'Taylor')
('FL100', '2023-06-01', 'Jones')
*/