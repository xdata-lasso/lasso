-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1001, 'Allison Hill', 1004, 'North Jefferyhaven', 'Fiji', 1007);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1002, 'Noah Rhodes', 1011.0, 'New Jamesside', 'Fiji', 1007);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1003, 'Angie Henderson', 1018.0, 'Robinsonshire', 'Fiji', 1007);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1008, 'Abigail Shaffer', 1011, 'West Melanieview', 'Switzerland', 1014);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1009, 'Gina Moore', 1018.0, 'Lake Stephenville', 'Switzerland', 1014);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1010, 'Gabrielle Davis', 1025.0, 'Millerport', 'Switzerland', 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country_other AS country FROM (SELECT LHS.country AS country, LHS.opening_year AS opening_year, LHS.n AS n, RHS.country AS country_other, RHS.opening_year AS opening_year_other, RHS.n AS n_other FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS CROSS JOIN (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS RHS) WHERE (n < n_other) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Fiji',)
*/