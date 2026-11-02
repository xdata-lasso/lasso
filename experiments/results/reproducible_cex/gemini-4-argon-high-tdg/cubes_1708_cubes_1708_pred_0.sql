-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'Munich', 'Germany', 'MUC', 'EDDM', 'Munich Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'Berlin', 'Germany', 'BER', 'EDDB', 'Brandenburg Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (3, 'Toronto', 'Canada', 'YYZ', 'CYYZ', 'Pearson Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (4, 'Zap', 'Brazil', 'ZAP', 'SBZP', 'Zap Regional');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (5, 'Rio', 'Brazil', 'GIG', 'SBGL', 'Galeao Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (6, 'Sao Paulo', 'Brazil', 'GRU', 'SBGR', 'Guarulhos Airport');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Air France', 'Airline', 'Passenger', 'France', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Freight France', 'Cargo', 'Logistics', 'France', 50.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'Air Canada', 'Airline', 'Passenger', 'Canada', 100.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 3, 3, 'AC101', '2023-01-01', 'Smith', 800.0, 35000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 3, 3, 'AC102', '2023-01-02', 'Jones', 810.0, 36000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 3, 3, 'AC103', '2023-01-03', 'Taylor', 790.0, 34000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) WHERE (n >= 2) ORDER BY country;

/*
Gold Result:
('Brazil',)
('Germany',)
*/

-- Prediction Query
SELECT country FROM airport GROUP BY country HAVING COUNT(*) > 2;

/*
Prediction Result:
('Brazil',)
*/