-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("id", "Country") VALUES (1, NULL);
INSERT INTO "airport" ("id", "Country") VALUES (2, 'A');
INSERT INTO "airport" ("id", "Country") VALUES (3, 'B');
INSERT INTO "airport" ("id", "Country") VALUES (4, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airport GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'A')
(1, None)
(2, 'B')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airport GROUP BY country;

/*
Prediction Result:
(1, None)
(1, 'A')
(2, 'B')
*/