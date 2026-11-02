-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1001, 'Allison Hill', 1004, 'North Jefferyhaven', 'Fiji', 1007);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1002, 'Noah Rhodes', 1011.0, 'New Jamesside', 'Fiji', 1020.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1003, 'Angie Henderson', 1018.0, 'Robinsonshire', 'Fiji', 1033.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM stadium GROUP BY country) WHERE (n < 3) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country HAVING COUNT(*) <= 3;

/*
Prediction Result:
('Fiji',)
*/