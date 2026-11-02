-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filter (Country <> 'Iceland'), alphabetical ordering by name, and duplicate name handling (killing DISTINCT mutants).
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'Reykjavik', 'Iceland', 'KEF', 'BIKF', 'Keflavik International');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'London', 'United Kingdom', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (3, 'Paris', 'France', 'CDG', 'LFPG', 'Charles de Gaulle');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (4, 'Manchester', 'United Kingdom', 'MAN', 'EGCC', 'Heathrow');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airport" WHERE ("country" <> 'Iceland') ORDER BY name, airport.id NULLS LAST;

/*
Gold Result:
('Charles de Gaulle',)
('Heathrow',)
('Heathrow',)
*/

-- Prediction Query
SELECT name FROM airport WHERE country <> 'Iceland';

/*
Prediction Result:
('Heathrow',)
('Charles de Gaulle',)
('Heathrow',)
*/