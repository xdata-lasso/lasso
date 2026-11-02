-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (-5, 'Zurich', 'Switzerland', 'ZRH', 'LSZH', 'Kloten Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'Tokyo', 'Japan', 'HND', 'RJTT', 'Haneda Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (10, 'London', 'United Kingdom', 'LHR', 'EGLL', 'Heathrow Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (25, 'Atlanta', 'United States', 'ATL', 'KATL', 'Hartsfield-Jackson');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Global Air', 'Public', 'Passenger transport', 'United Kingdom', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Pacific Wings', 'Private', 'Cargo', 'Japan', 75.5);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (101, 1, 10, 'BA-100', '2023-05-01', 'John Smith', 850.0, 35000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (102, 2, 10, 'PW-200', '2023-05-02', 'Kenji Sato', 820.0, 33000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (103, 1, 25, 'BA-300', '2023-05-03', 'Alice Brown', 880.0, 37000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, country, city, name FROM airport ORDER BY id;

/*
Gold Result:
(-5, 'Switzerland', 'Zurich', 'Kloten Airport')
(2, 'Japan', 'Tokyo', 'Haneda Airport')
(10, 'United Kingdom', 'London', 'Heathrow Airport')
(25, 'United States', 'Atlanta', 'Hartsfield-Jackson')
*/

-- Prediction Query
SELECT id, country, city, name FROM airport ORDER BY name, airport.id NULLS LAST;

/*
Prediction Result:
(2, 'Japan', 'Tokyo', 'Haneda Airport')
(25, 'United States', 'Atlanta', 'Hartsfield-Jackson')
(10, 'United Kingdom', 'London', 'Heathrow Airport')
(-5, 'Switzerland', 'Zurich', 'Kloten Airport')
*/