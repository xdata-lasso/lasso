-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flight" ("id", "Vehicle_Flight_number", "Date", "Pilot", "Altitude") VALUES (1, 'B', '2023-01-01', 'John', 100.0);
INSERT INTO "flight" ("id", "Vehicle_Flight_number", "Date", "Pilot", "Altitude") VALUES (2, 'A', '2023-01-02', 'Jane', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY vehicle_flight_number, flight.id NULLS LAST;

/*
Gold Result:
('A', '2023-01-02', 'Jane')
('B', '2023-01-01', 'John')
*/

-- Prediction Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY altitude ASC, flight.id NULLS LAST;

/*
Prediction Result:
('B', '2023-01-01', 'John')
('A', '2023-01-02', 'Jane')
*/