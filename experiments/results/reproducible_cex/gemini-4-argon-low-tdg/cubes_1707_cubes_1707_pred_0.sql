-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'Madrid', 'Spain', 'MAD', 'LEMD', 'Barajas');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'Lisbon', 'Portugal', 'LIS', 'LPPT', 'Portela');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (3, 'Dublin', 'Ireland', 'DUB', 'EIDW', 'Dublin Intl');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Iberia', 'Commercial', 'Cargo', 'Spain', 50.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 1, 2, 'IB01', '2023-03-01', 'Victor', 300.0, 20000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 1, 2, 'IB02', '2023-03-02', 'Wendy', 300.0, 21000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 1, 1, 'IB03', '2023-03-03', 'Xander', 350.0, 22000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (4, 1, 3, 'IB04', '2023-03-04', 'Yara', 400.0, 23000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (5, 1, 3, 'IB05', '2023-03-05', 'Zack', 450.0, 24000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pilot FROM (SELECT airport_id, velocity, n, vehicle_flight_number, date, pilot, velocity_other, altitude, company_id, airport_id AS id FROM (SELECT LHS.airport_id AS airport_id, LHS.velocity AS velocity, LHS.n AS n, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity_other, RHS.altitude AS altitude, RHS.company_id AS company_id FROM (SELECT airport_id, velocity, COUNT(*) AS n FROM flight GROUP BY airport_id, velocity) AS LHS INNER JOIN flight AS RHS ON (LHS.airport_id = RHS.id AND LHS.n = RHS.airport_id))) ORDER BY pilot;

/*
Gold Result:
('Wendy',)
('Xander',)
*/

-- Prediction Query
SELECT pilot FROM flight GROUP BY pilot ORDER BY COUNT(*) DESC, pilot NULLS LAST LIMIT 1;

/*
Prediction Result:
('Victor',)
*/