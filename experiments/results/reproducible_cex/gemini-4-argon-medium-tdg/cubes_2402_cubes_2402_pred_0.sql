-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic boundary conditions for COUNT(*) < 3 (counts of 1, 2, 3, and 4) and ORDER BY country.
-- Also tests mutants that wrongly JOIN with the event table (only some stadiums have events).
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Stadium Z1', 10000, 'City Z', 'Zambia', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Stadium Z2', 15000, 'City Z', 'Zambia', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Stadium A1', 20000, 'City A', 'Argentina', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Stadium B1', 25000, 'City B', 'Brazil', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Stadium B2', 30000, 'City B', 'Brazil', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Stadium B3', 35000, 'City B', 'Brazil', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'Stadium C1', 40000, 'City C', 'Canada', 1980);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (8, 'Stadium C2', 45000, 'City C', 'Canada', 1985);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (9, 'Stadium C3', 50000, 'City C', 'Canada', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (10, 'Stadium C4', 55000, 'City C', 'Canada', 1995);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Event 1', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 4, 'Event 2', '2021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM stadium GROUP BY country) WHERE (n < 3) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Zambia',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country HAVING COUNT(*) <= 3;

/*
Prediction Result:
('Argentina',)
('Brazil',)
('Zambia',)
*/