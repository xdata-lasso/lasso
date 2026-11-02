-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Opening_year (ASC vs DESC) and inverted correlations with ID, Capacity, and Name.
-- Also tests extraneous INNER JOINs with event/record by leaving them empty.
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (10, 'Alpha', 50000, 'CityA', 'CountryA', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (20, 'Beta', 10000, 'CityB', 'CountryB', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (30, 'Gamma', 30000, 'CityC', 'CountryC', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM stadium ORDER BY opening_year, stadium.id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Beta',)
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/