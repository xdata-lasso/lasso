-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airport (id, city, country, iata, icao, name) VALUES (0, 'default1', 'default2', NULL, 'default2', 'default1'), (1, NULL, NULL, 'default2', 'default2', 'default2'), (2, 'default2', 'default1', 'default2', NULL, NULL), (3, 'default2', NULL, 'default1', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, country, city, name FROM airport ORDER BY id;

/*
Gold Result:
(0, 'default2', 'default1', 'default1')
(1, None, None, 'default2')
(2, 'default1', 'default2', None)
(3, None, 'default2', None)
*/

-- Prediction Query
SELECT id, country, city, name FROM airport ORDER BY name, airport.id NULLS LAST;

/*
Prediction Result:
(2, 'default1', 'default2', None)
(3, None, 'default2', None)
(0, 'default2', 'default1', 'default1')
(1, None, None, 'default2')
*/