-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airport (id, city, country, iata, icao, name) VALUES (2, NULL, 'default2', NULL, NULL, 'default1'), (3, 'default1', 'default1', 'default2', 'default2', 'default1'), (0, NULL, NULL, NULL, 'default1', NULL), (1, 'default1', 'default2', 'default2', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) WHERE (n >= 2) ORDER BY country;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT country FROM airport GROUP BY country HAVING COUNT(*) > 2;

/*
Prediction Result:
*/