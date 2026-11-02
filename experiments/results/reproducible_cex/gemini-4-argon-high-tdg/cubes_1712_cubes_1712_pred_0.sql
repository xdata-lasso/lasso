-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'Madrid', 'Spain', 'MAD', 'LEMD', 'Barajas');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'Toronto', 'Canada', 'YYZ', 'CYYZ', 'Pearson');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (3, 'Paris', 'France', 'CDG', 'LFPG', 'Charles de Gaulle');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (4, 'Paris', 'France', 'ORY', 'LFPO', 'Orly');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (5, 'Lyon', 'France', 'LYS', 'LFLL', 'Saint-Exupery');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (6, 'Rio', 'Brazil', 'GIG', 'SBGL', 'Galeao');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (7, 'Sao Paulo', 'Brazil', 'GRU', 'SBGR', 'Guarulhos');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (8, 'Sydney', 'Australia', 'SYD', 'YSSY', 'Kingsford Smith');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (9, 'Melbourne', 'Australia', 'MEL', 'YMML', 'Tullamarine');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Iberia', 'Airline', 'Passenger', 'Spain', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'Air France', 'Airline', 'Passenger', 'France', 80.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 1, 1, 'IB101', '2023-01-01', 'Smith', 800.0, 10000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 1, 1, 'IB102', '2023-01-02', 'Jones', 810.0, 10500.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 1, 1, 'IB103', '2023-01-03', 'Brown', 820.0, 11000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (4, 2, 3, 'AF201', '2023-01-04', 'Dupont', 850.0, 11500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'Canada')
(1, 'Spain')
(2, 'Australia')
(2, 'Brazil')
(3, 'France')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airport GROUP BY country;

/*
Prediction Result:
(2, 'Australia')
(2, 'Brazil')
(1, 'Canada')
(3, 'France')
(1, 'Spain')
*/