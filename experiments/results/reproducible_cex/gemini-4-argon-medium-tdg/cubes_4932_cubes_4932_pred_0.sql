-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (country, opening_year) vs GROUP BY country vs GROUP BY opening_year, and MAX vs MIN.
-- USA has 4 stadiums total (2 in 1990, 2 in 2000), while UK has 3 stadiums in 1995.
-- Year 1990 has 4 stadiums total across USA and Canada.
-- Correct result: 'UK' (max count for a (country, opening_year) pair is 3).
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'S1', 1000, 'NY', 'USA', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'S2', 2000, 'LA', 'USA', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'S3', 1500, 'Chicago', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'S4', 2500, 'Houston', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'S5', 3000, 'London', 'UK', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'S6', 3500, 'Manchester', 'UK', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'S7', 4000, 'Liverpool', 'UK', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (8, 'S8', 5000, 'Toronto', 'Canada', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (9, 'S9', 5500, 'Montreal', 'Canada', 1990);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (10, 'S10', 6000, 'Paris', 'France', 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT * FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT MAX(n) AS n FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year)) AS RHS WHERE (LHS.n = RHS.n))) ORDER BY country;

/*
Gold Result:
('UK',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/