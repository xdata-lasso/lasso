-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (country, opening_year) vs GROUP BY (country) vs GROUP BY (opening_year)
-- Also tests MAX vs MIN, and INNER JOIN vs standalone stadium table.
-- Here:
-- ('USA', 2000) -> count 2
-- ('USA', 2004) -> count 2
-- ('Canada', 2000) -> count 3 (Winner for (country, opening_year))
-- ('UK', 2008) -> count 1
-- Total by country: USA=4, Canada=3, UK=1. (Kills GROUP BY country only)
-- Total by year: 2000=5, 2004=2, 2008=1.
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'S1', 50000, 'NY', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'S2', 60000, 'LA', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'S3', 55000, 'Chicago', 'USA', 2004);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'S4', 45000, 'Houston', 'USA', 2004);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'S5', 40000, 'Toronto', 'Canada', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'S6', 35000, 'Montreal', 'Canada', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'S7', 30000, 'Vancouver', 'Canada', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (8, 'S8', 80000, 'London', 'UK', 2008);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'E1', '2001');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT * FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT MAX(n) AS n FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year)) AS RHS WHERE (LHS.n = RHS.n))) ORDER BY country;

/*
Gold Result:
('Canada',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/