-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'London', 'UK', 'LHR', 'EGLL', 'Alpha');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'Paris', 'France', 'CDG', 'LFPG', 'Beta');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (3, 'Berlin', 'Germany', 'BER', 'EDDB', 'Gamma');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (4, 'Madrid', 'Spain', 'MAD', 'LEMD', 'Delta');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Alpha', 'Corporate', 'Flights', 'UK', 50.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Beta', 'LLC', 'Cargo', 'France', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'MismatchName', 'Corp', ' Charter', 'Germany', 25.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (5, 'Delta', 'Corp', 'Passenger', 'Spain', 75.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (101, 1, 2, 'F100', '2023-01-01', 'Smith', 500.0, 30000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (102, 2, 3, 'F101', '2023-01-02', 'Jones', 550.0, 32000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (103, 5, 3, 'F102', '2023-01-03', 'Smith', 520.0, 31000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airport_id AS id, n AS count___ FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, LHS.type AS TYPE, LHS.principal_activities AS principal_activities, LHS.incorporated_in AS incorporated_in, LHS.group_equity_shareholding AS group_equity_shareholding, RHS.airport_id AS airport_id, RHS.n AS n FROM (SELECT LHS.id AS id, LHS.city AS city, LHS.country AS country, LHS.iata AS iata, LHS.icao AS icao, LHS.name AS name, RHS.type AS TYPE, RHS.principal_activities AS principal_activities, RHS.incorporated_in AS incorporated_in, RHS.group_equity_shareholding AS group_equity_shareholding FROM airport AS LHS INNER JOIN operate_company AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name)) AS LHS CROSS JOIN (SELECT airport_id, COUNT(*) AS n FROM flight GROUP BY airport_id) AS RHS) ORDER BY id, count___ NULLS LAST;

/*
Gold Result:
(2, 1)
(2, 1)
(3, 2)
(3, 2)
*/

-- Prediction Query
SELECT T3.id, COUNT(*) FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id JOIN airport AS T3 ON T2.airport_id = T3.id GROUP BY T3.id;

/*
Prediction Result:
(2, 1)
(3, 2)
*/