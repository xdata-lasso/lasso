-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests column projection order, out-of-order insertion, and numeric vs lexicographical ordering on id.
-- Also tests erroneous joins with flight (0 flights, 1 flight, multiple flights) and operate_company (conflicting name column).
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (10, 'AlphaCity', 'ZetaCountry', 'AAA', 'AAAA', 'MiddleName');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (2, 'ZetaCity', 'AlphaCountry', 'ZZZ', 'ZZZZ', 'FirstName');
INSERT INTO "airport" ("id", "City", "Country", "IATA", "ICAO", "name") VALUES (1, 'BetaCity', 'BetaCountry', 'BBB', 'BBBB', 'LastName');
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (1, 'CompanyOne', 'Commercial', 'Flights', 'USA', 50.0);
INSERT INTO "operate_company" ("id", "name", "Type", "Principal_activities", "Incorporated_in", "Group_Equity_Shareholding") VALUES (2, 'CompanyTwo', 'Cargo', 'Logistics', 'UK', 100.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (101, 1, 2, 'FL-001', '2023-01-01', 'Smith', 500.0, 30000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (102, 2, 2, 'FL-002', '2023-01-02', 'Jones', 550.0, 32000.0);
INSERT INTO "flight" ("id", "company_id", "airport_id", "Vehicle_Flight_number", "Date", "Pilot", "Velocity", "Altitude") VALUES (103, 1, 10, 'FL-003', '2023-01-03', 'Taylor', 480.0, 28000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, country, city, name FROM airport ORDER BY id;

/*
Gold Result:
(1, 'BetaCountry', 'BetaCity', 'LastName')
(2, 'AlphaCountry', 'ZetaCity', 'FirstName')
(10, 'ZetaCountry', 'AlphaCity', 'MiddleName')
*/

-- Prediction Query
SELECT id, country, city, name FROM airport ORDER BY name, airport.id NULLS LAST;

/*
Prediction Result:
(2, 'AlphaCountry', 'ZetaCity', 'FirstName')
(1, 'BetaCountry', 'BetaCity', 'LastName')
(10, 'ZetaCountry', 'AlphaCity', 'MiddleName')
*/