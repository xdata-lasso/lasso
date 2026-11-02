-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'Chicago', 'USA', 'ORD', 'KORD', 'OHare');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'New York', 'USA', 'JFK', 'KJFK', 'Kennedy');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (3, 'Toronto', 'Canada', 'YYZ', 'CYYZ', 'Pearson');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (4, 'Paris', 'France', 'CDG', 'LFPG', 'Charles de Gaulle');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (5, 'Lyon', 'France', 'LYS', 'LFLL', 'Saint-Exupery');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (6, 'Marseille', 'France', 'MRS', 'LFML', 'Provence');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) WHERE (n >= 2) ORDER BY country;

/*
Gold Result:
('France',)
('USA',)
*/

-- Prediction Query
SELECT country FROM airport GROUP BY country HAVING COUNT(*) > 2;

/*
Prediction Result:
('France',)
*/