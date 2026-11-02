-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Stadium A', 10000, 'City1', 'Zambia', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Stadium B', 20000, 'City2', 'Brazil', 2001);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Stadium C', 30000, 'City3', 'Brazil', 2001);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Stadium D', 15000, 'City4', 'Brazil', 2002);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Stadium E', 25000, 'City5', 'Brazil', 2002);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Stadium F', 40000, 'City6', 'Argentina', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'Stadium G', 50000, 'City7', 'Argentina', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (8, 'Stadium H', 60000, 'City8', 'Argentina', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country_other AS country FROM (SELECT LHS.country AS country, LHS.opening_year AS opening_year, LHS.n AS n, RHS.country AS country_other, RHS.opening_year AS opening_year_other, RHS.n AS n_other FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS CROSS JOIN (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS RHS) WHERE (n < n_other) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Brazil',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Brazil',)
*/