-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (10, 'New York', 'USA', 'JFK', 'KJFK', 'John F. Kennedy International');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Global Air', 'Passenger', 'International Flights', 'USA', 60.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Global Air', 'Cargo', 'Logistics', 'USA', 40.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'Apex Jet', 'Corporate', 'VIP Transport', 'USA', 90.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (4, 'Apex Jet', 'Corporate', 'Domestic VIP', 'Canada', 75.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (101, 1, 10, 'GA001', '2023-06-10', 'Adams', 900.0, 36000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (102, 2, 10, 'GA002', '2023-06-11', 'Baker', 820.0, 33000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (103, 2, 10, 'GA003', '2023-06-12', 'Clark', 830.0, 34000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (104, 3, 10, 'AJ100', '2023-06-13', 'Davis', 780.0, 40000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (105, 4, 10, 'AJ200', '2023-06-14', 'Evans', 790.0, 41000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TYPE FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.id AS id_other, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity, RHS.altitude AS altitude, RHS.airport_id AS airport_id FROM operate_company AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY name, TYPE NULLS LAST;

/*
Gold Result:
('Apex Jet', 'Corporate')
('Apex Jet', 'Corporate')
('Global Air', 'Cargo')
('Global Air', 'Cargo')
('Global Air', 'Passenger')
*/

-- Prediction Query
SELECT T1.name, T1.type FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id;

/*
Prediction Result:
('Global Air', 'Passenger')
('Global Air', 'Cargo')
('Global Air', 'Cargo')
('Apex Jet', 'Corporate')
('Apex Jet', 'Corporate')
*/