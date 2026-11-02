-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY name, TYPE NULLS LAST (ties on name, secondary sort on Type, and NULL handling in both columns).
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'Paris', 'France', 'CDG', 'LFPG', 'Charles de Gaulle');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Zenith', 'Regional', 'Flights', 'France', 80.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Apex', 'Private', 'Charter', 'France', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'Apex', 'Commercial', 'Passenger', 'France', 60.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (4, 'Apex', NULL, 'Unknown', 'France', 40.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (5, NULL, 'Cargo', 'Freight', 'France', 90.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (6, NULL, NULL, 'None', 'France', 10.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 1, 1, 'F1', '2023-05-01', 'P1', 400.0, 20000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 2, 1, 'F2', '2023-05-02', 'P2', 410.0, 21000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 3, 1, 'F3', '2023-05-03', 'P3', 420.0, 22000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (4, 4, 1, 'F4', '2023-05-04', 'P4', 430.0, 23000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (5, 5, 1, 'F5', '2023-05-05', 'P5', 440.0, 24000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (6, 6, 1, 'F6', '2023-05-06', 'P6', 450.0, 25000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TYPE FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.id AS id_other, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity, RHS.altitude AS altitude, RHS.airport_id AS airport_id FROM operate_company AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY name, TYPE NULLS LAST;

/*
Gold Result:
(None, 'Cargo')
(None, None)
('Apex', 'Commercial')
('Apex', 'Private')
('Apex', None)
('Zenith', 'Regional')
*/

-- Prediction Query
SELECT T1.name, T1.type FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id;

/*
Prediction Result:
('Zenith', 'Regional')
('Apex', 'Private')
('Apex', 'Commercial')
('Apex', None)
(None, 'Cargo')
(None, None)
*/