-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'Tokyo', 'Japan', 'HND', 'RJTT', 'Zeta International');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'Reykjavik', 'Iceland', 'KEF', 'BIKF', 'Keflavik Airport');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (3, 'Copenhagen', 'Denmark', 'CPH', 'EKCH', 'Alpha Hub');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (4, 'Sao Paulo', 'Brazil', 'GRU', 'SBGR', 'Beta Terminal');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (5, 'New York', 'USA', 'JFK', 'KJFK', 'Alpha Hub');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'Nordic Air', 'Commercial', 'Passenger transport', 'Denmark', 100.0);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (2, 'Atlantic Wings', 'Cargo', 'Freight', 'Iceland', 55.5);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (1, 1, 1, 'NA101', '2023-01-10', 'Smith', 850.0, 35000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (2, 1, 1, 'NA102', '2023-01-11', 'Jones', 860.0, 36000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (3, 2, 2, 'AW201', '2023-01-12', 'Taylor', 780.0, 32000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airport" WHERE ("country" <> 'Iceland') ORDER BY name, airport.id NULLS LAST;

/*
Gold Result:
('Alpha Hub',)
('Alpha Hub',)
('Beta Terminal',)
('Zeta International',)
*/

-- Prediction Query
SELECT name FROM airport WHERE country <> 'Iceland';

/*
Prediction Result:
('Zeta International',)
('Alpha Hub',)
('Beta Terminal',)
('Alpha Hub',)
*/