-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Boundary testing on Velocity (>= 200.0), GROUP BY (altitude, velocity) vs single-column GROUP BY, and ORDER BY count___ with duplicate counts
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'AirCorp', 'Commercial', 'Flights', 'UK', 100.0);
-- Group 1: velocity = 199.9 (excluded by velocity >= 200.0), count = 1
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 1, 1, 'F1', '2023-01-01', 'P1', 199.9, 1000.0);
-- Group 2: velocity = 200.0 (boundary included), altitude = 1000.0, count = 2
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 1, 1, 'F2', '2023-01-01', 'P2', 200.0, 1000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 1, 1, 'F3', '2023-01-01', 'P3', 200.0, 1000.0);
-- Group 3: velocity = 200.0 (boundary included), altitude = 2000.0 (tests grouping by BOTH altitude and velocity), count = 1
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (4, 1, 1, 'F4', '2023-01-01', 'P4', 200.0, 2000.0);
-- Group 4: velocity = 250.0, altitude = 1000.0 (tests grouping by velocity when altitude is same as Group 2), count = 3
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (5, 1, 1, 'F5', '2023-01-01', 'P5', 250.0, 1000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (6, 1, 1, 'F6', '2023-01-01', 'P6', 250.0, 1000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (7, 1, 1, 'F7', '2023-01-01', 'P7', 250.0, 1000.0);
-- Group 5: velocity = 300.0, altitude = 3000.0, count = 1 (tests duplicate count___ in output vs SELECT DISTINCT)
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (8, 1, 1, 'F8', '2023-01-01', 'P8', 300.0, 3000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT altitude, velocity, COUNT(*) AS n FROM flight GROUP BY altitude, velocity) WHERE (n <> 200 AND velocity >= 200.0) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM flight WHERE velocity > 200;

/*
Prediction Result:
(4,)
*/