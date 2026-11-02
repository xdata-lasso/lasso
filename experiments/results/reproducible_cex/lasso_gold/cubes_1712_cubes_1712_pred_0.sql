-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1002, 'Johnsonland', 'Cuba', 'early', 'mouth', 'Kristina Baldwin');
INSERT INTO "airport" ("id", "city", "country", "iata", "icao", "name") VALUES (1005, 'Cassandraton', NULL, 'machine', 'not', 'Thomas Miller');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'Cuba')
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), country FROM airport GROUP BY country;

/*
Prediction Result:
(1, None)
(1, 'Cuba')
*/