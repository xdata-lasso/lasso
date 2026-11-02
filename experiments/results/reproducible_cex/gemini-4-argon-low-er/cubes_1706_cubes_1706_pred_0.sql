-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'London', 'UK', 'LHR', 'EGLL', 'Zeta Airport');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'Paris', 'France', 'CDG', 'LFPG', 'Alpha Airport');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, country, city, name FROM airport ORDER BY id;

/*
Gold Result:
(1, 'UK', 'London', 'Zeta Airport')
(2, 'France', 'Paris', 'Alpha Airport')
*/

-- Prediction Query
SELECT id, country, city, name FROM airport ORDER BY name, airport.id NULLS LAST;

/*
Prediction Result:
(2, 'France', 'Paris', 'Alpha Airport')
(1, 'UK', 'London', 'Zeta Airport')
*/