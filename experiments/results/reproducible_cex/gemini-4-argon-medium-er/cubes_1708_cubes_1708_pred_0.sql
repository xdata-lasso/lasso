-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'New York', 'USA', 'JFK', 'KJFK', 'John F. Kennedy');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'Los Angeles', 'USA', 'LAX', 'KLAX', 'Los Angeles Intl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) WHERE (n >= 2) ORDER BY country;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT country FROM airport GROUP BY country HAVING COUNT(*) > 2;

/*
Prediction Result:
*/