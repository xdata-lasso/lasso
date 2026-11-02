-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties in MAX(capacity), ordering by name vs ID, and negative/zero capacities.
-- Also includes rows with no corresponding events to kill mutants that inner join the event table.
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Zeta Arena', 50000, 'Alpha City', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Alpha Dome', 50000, 'Beta City', 'UK', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Mid Center', 25000, 'Gamma City', 'Canada', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Zero Field', 0, 'Delta City', 'France', 1980);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Neg Stadium', -100, 'Epsilon City', 'Germany', 1970);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year FROM stadium AS LHS INNER JOIN (SELECT id, name, MAX(capacity) OVER () AS capacity, city, country, opening_year FROM stadium) AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name AND LHS.capacity = RHS.capacity AND LHS.city = RHS.city AND LHS.country = RHS.country AND LHS.opening_year = RHS.opening_year)) ORDER BY name;

/*
Gold Result:
('Alpha Dome',)
('Zeta Arena',)
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Arena',)
*/