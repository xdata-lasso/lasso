-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT JOIN, duplicate rows (SELECT vs SELECT DISTINCT), and basic ORDER BY name, TYPE.
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'New York', 'USA', 'JFK', 'KJFK', 'John F. Kennedy');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Beta Air', 'Commercial', 'Passenger', 'USA', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Alpha Air', 'Cargo', 'Freight', 'UK', 80.5);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'Alpha Air', 'Commercial', 'Passenger', 'USA', 50.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (4, 'Ghost Air', 'Charter', 'VIP', 'France', 10.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 1, 1, 'BA101', '2023-01-01', 'Smith', 500.0, 30000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 1, 1, 'BA102', '2023-01-02', 'Jones', 510.0, 31000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 2, 1, 'AA201', '2023-01-03', 'Taylor', 480.0, 28000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (4, 3, 1, 'AA301', '2023-01-04', 'Brown', 520.0, 32000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (5, NULL, 1, 'UN999', '2023-01-05', 'Unknown', 400.0, 20000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TYPE FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.id AS id_other, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity, RHS.altitude AS altitude, RHS.airport_id AS airport_id FROM operate_company AS LHS INNER JOIN flight AS RHS ON (LHS.id = RHS.company_id)) ORDER BY name, TYPE NULLS LAST;

/*
Gold Result:
('Alpha Air', 'Cargo')
('Alpha Air', 'Commercial')
('Beta Air', 'Commercial')
('Beta Air', 'Commercial')
*/

-- Prediction Query
SELECT T1.name, T1.type FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id;

/*
Prediction Result:
('Beta Air', 'Commercial')
('Beta Air', 'Commercial')
('Alpha Air', 'Cargo')
('Alpha Air', 'Commercial')
*/