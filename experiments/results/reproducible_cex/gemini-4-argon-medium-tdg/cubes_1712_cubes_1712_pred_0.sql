-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting, primary ordering by count (ASC), secondary tie-breaking by Country (ASC), and joins vs standalone table (airport rows with 0, 1, and multiple flights).
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'Paris', 'France', 'CDG', 'LFPG', 'Charles de Gaulle');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'Lyon', 'France', 'LYS', 'LFLL', 'Lyon-Saint Exupery');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (3, 'Nice', 'France', 'NCE', 'LFMN', 'Nice Cote dAzur');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (4, 'Berlin', 'Germany', 'BER', 'EDDB', 'Brandenburg');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (5, 'Munich', 'Germany', 'MUC', 'EDDM', 'Franz Josef Strauss');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (6, 'Madrid', 'Spain', 'MAD', 'LEMD', 'Barajas');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (7, 'Barcelona', 'Spain', 'BCN', 'LEBL', 'El Prat');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (8, 'Rome', 'Italy', 'FCO', 'LIRF', 'Fiumicino');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'EuroAir', 'Commercial', 'Passenger', 'France', 100.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 1, 'EA101', '2023-01-01', 'Smith', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'EA102', '2023-01-02', 'Jones', 520.0, 31000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (3, 1, 4, 'EA201', '2023-01-03', 'Taylor', 480.0, 29000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'Italy')
(2, 'Germany')
(2, 'Spain')
(3, 'France')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airport GROUP BY country;

/*
Prediction Result:
(3, 'France')
(2, 'Germany')
(1, 'Italy')
(2, 'Spain')
*/