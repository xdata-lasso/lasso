-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO operate_company (id, name, type, principal_activities, incorporated_in, group_equity_shareholding) VALUES (0, NULL, 'default2', NULL, NULL, 0.0), (1, 'default1', 'default2', 'default2', NULL, NULL);
INSERT INTO airport (id, city, country, iata, icao, name) VALUES (0, 'default1', 'default2', NULL, 'default1', 'default2'), (1, 'default1', NULL, 'default1', 'default1', NULL), (2, NULL, 'default2', 'default2', 'default1', NULL);
INSERT INTO flight (id, company_id, airport_id, vehicle_flight_number, date, pilot, velocity, altitude) VALUES (1, NULL, 1, 'default2', 'default2', NULL, NULL, 1.0), (0, 1, 0, 'default2', 'default1', 'default2', 1.0, NULL), (2, 1, 2, 'default2', NULL, NULL, 1.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY vehicle_flight_number, flight.id NULLS LAST;

/*
Gold Result:
('default2', 'default1', 'default2')
('default2', 'default2', None)
('default2', None, None)
*/

-- Prediction Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY altitude ASC, flight.id NULLS LAST;

/*
Prediction Result:
('default2', 'default1', 'default2')
('default2', None, None)
('default2', 'default2', None)
*/