-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airport (id, city, country, iata, icao, name) VALUES (0, 'Iceland', 'default1', 'Iceland', 'default1', 'default2'), (1, 'default1', 'default2', NULL, 'Iceland', 'Iceland');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airport" WHERE ("country" <> 'Iceland') ORDER BY name, airport.id NULLS LAST;

/*
Gold Result:
('Iceland',)
('default2',)
*/

-- Prediction Query
SELECT name FROM airport WHERE country <> 'Iceland';

/*
Prediction Result:
('default2',)
('Iceland',)
*/