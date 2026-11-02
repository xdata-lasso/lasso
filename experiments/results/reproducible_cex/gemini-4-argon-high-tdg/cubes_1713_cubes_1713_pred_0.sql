-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'New York', 'USA', 'JFK', 'KJFK', 'Global Air');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'Los Angeles', 'USA', 'LAX', 'KLAX', 'Pacific Hub');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (3, 'Chicago', 'USA', 'ORD', 'KORD', 'Metro Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (4, 'Houston', 'USA', 'IAH', 'KIAH', 'Shared Name');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Global Air', 'Public', 'Airline', 'USA', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Pacific Hub', 'Private', 'Logistics', 'UK', 55.5);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'Different Corp', 'Public', 'Cargo', 'Canada', 75.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (5, 'Shared Name', 'Private', 'Charter', 'USA', 25.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (101, 1, 3, 'FL301', '2023-01-01', 'Smith', 500.0, 30000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (102, 2, 3, 'FL302', '2023-01-02', 'Jones', 510.0, 31000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (103, 3, 3, 'FL303', '2023-01-03', 'Taylor', 520.0, 32000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (104, 5, 4, 'FL401', '2023-01-04', 'Brown', 480.0, 29000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (105, 1, 1, 'FL101', '2023-01-05', 'Davis', 490.0, 30500.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (106, 2, 1, 'FL102', '2023-01-06', 'Wilson', 495.0, 30800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airport_id AS id, n AS count___ FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.airport_id AS airport_id, RHS.n AS n FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, RHS.type AS TYPE, RHS.principal_activities AS principal_activities, RHS.incorporated_in AS incorporated_in, RHS.group_equity_shareholding AS group_equity_shareholding FROM airport AS LHS INNER JOIN operate_company AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name)) AS LHS CROSS JOIN (SELECT airport_id, COUNT(*) AS n FROM flight GROUP BY airport_id) AS RHS) ORDER BY id, count___ NULLS LAST;

/*
Gold Result:
(1, 2)
(1, 2)
(3, 3)
(3, 3)
(4, 1)
(4, 1)
*/

-- Prediction Query
SELECT T3.id, COUNT(*) FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id JOIN airport AS T3 ON T2.airport_id = T3.id GROUP BY T3.id;

/*
Prediction Result:
(1, 2)
(3, 3)
(4, 1)
*/