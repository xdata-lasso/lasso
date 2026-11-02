-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact equality with the mean (Capacity = 200 when mean = 200), ordering by name vs ordering by capacity/id, and non-matching column values (Opening_year vs Capacity).
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Bravo', 100, 'CityA', 'CountryA', 2020);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Charlie', 200, 'CityA', 'CountryA', 1950);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Alpha', 150, 'CityB', 'CountryB', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Delta', 350, 'CityB', 'CountryB', 1900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, capacity, city, country, opening_year, AVG(capacity) OVER () AS meancapacity FROM stadium) WHERE (meancapacity > capacity) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Bravo',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE capacity < (SELECT AVG(capacity) FROM stadium);

/*
Prediction Result:
('Bravo',)
('Alpha',)
*/