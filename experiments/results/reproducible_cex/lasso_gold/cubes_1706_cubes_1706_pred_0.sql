-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1004, 'Joshuaborough', 'Fiji', 'great', 'blue', 'Brent Abbott');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1003, 'Robinsonshire', 'Serbia', 'table', 'true', 'Robert Wolfe');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, country, city, name FROM airport ORDER BY id;

/*
Gold Result:
(1003, 'Serbia', 'Robinsonshire', 'Robert Wolfe')
(1004, 'Fiji', 'Joshuaborough', 'Brent Abbott')
*/

-- Prediction Query
SELECT id, country, city, name FROM airport ORDER BY name, airport.id NULLS LAST;

/*
Prediction Result:
(1004, 'Fiji', 'Joshuaborough', 'Brent Abbott')
(1003, 'Serbia', 'Robinsonshire', 'Robert Wolfe')
*/