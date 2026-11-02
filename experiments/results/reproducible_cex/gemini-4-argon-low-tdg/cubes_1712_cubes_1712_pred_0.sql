-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. GROUP BY Country vs GROUP BY City/IATA/id (cities, IATAs, names are identical across countries or distinct within countries).
-- 2. COUNT(*) vs COUNT(Country), COUNT(City), COUNT(IATA), COUNT(DISTINCT City) by including NULLs and duplicate attribute values.
-- 3. Primary ORDER BY count___ ASC vs DESC (counts of 1, 2, and 3).
-- 4. Secondary ORDER BY country ASC vs DESC with tie-breaking on count___ (Canada and Brazil both have count 2, inserted out of alphabetical order).
-- 5. NULLS LAST in secondary sort (NULL country has count 2, tied with Canada and Brazil).
-- 6. Unreferenced airports (no flights) vs airports with multiple flights (kills mutants that erroneously JOIN with flight).
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'London', 'Canada', NULL, NULL, 'London Int');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (3, 'Toronto', 'Canada', 'YYZ', 'CYYZ', 'Pearson');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (4, 'Sao Paulo', 'Brazil', 'GRU', 'SBGR', 'Guarulhos');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (5, 'Sao Paulo', 'Brazil', 'CGH', 'SBSP', 'Congonhas');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (6, NULL, NULL, NULL, NULL, 'Unknown 1');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (7, 'Unknown City', NULL, 'UNK', 'ZZZZ', 'Unknown 2');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (8, 'New York', 'USA', 'JFK', 'KJFK', 'JFK');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (9, 'New York', 'USA', 'LGA', 'KLGA', 'LaGuardia');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (10, 'Chicago', 'USA', NULL, 'KORD', 'OHare');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'Air Corp', 'Commercial', 'Airline', 'USA', 100.0);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (2, 'Euro Wing', 'Commercial', 'Cargo', 'France', 50.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 1, 'F100', '2023-01-01', 'Smith', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'F101', '2023-01-02', 'Smith', 510.0, 31000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (3, 1, 1, 'F102', '2023-01-03', 'Jones', 520.0, 32000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (4, 2, 2, 'F200', '2023-01-01', 'Brown', 480.0, 29000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'UK')
(2, 'Brazil')
(2, 'Canada')
(2, None)
(3, 'USA')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airport GROUP BY country;

/*
Prediction Result:
(2, None)
(2, 'Brazil')
(2, 'Canada')
(1, 'UK')
(3, 'USA')
*/