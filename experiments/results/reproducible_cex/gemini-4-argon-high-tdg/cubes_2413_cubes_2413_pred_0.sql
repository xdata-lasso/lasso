-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'John Doe', 'Canada', 50.5, '1:50', '2:50', '3:50', '4:50', '5:50', '6:50', '2020');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Maple Pool', 5000, 'Toronto', 'Canada', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Samba Arena', 3000, 'Rio', 'Brazil', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Copacabana Center', 4000, 'Rio', 'Brazil', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Amazonia Pool', 3500, 'Manaus', 'Brazil', 2015);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Paulista Complex', 4500, 'Sao Paulo', 'Brazil', 2015);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Coral Reef Park', 2000, 'Sydney', 'Australia', 2020);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'Outback Swim', 2500, 'Melbourne', 'Australia', 2020);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (8, 'Gold Coast Dome', 3000, 'Brisbane', 'Australia', 2020);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Winter Cup', '2011');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 1, 'Spring Cup', '2012');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 1, 'Summer Cup', '2013');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (4, 1, 'Autumn Cup', '2014');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (5, 2, 'Rio Open', '2006');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (6, 6, 'Sydney Classic', '2021');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country_other AS country FROM (SELECT LHS.country AS country, LHS.opening_year AS opening_year, LHS.n AS n, RHS.country AS country_other, RHS.opening_year AS opening_year_other, RHS.n AS n_other FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS CROSS JOIN (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS RHS) WHERE (n < n_other) ORDER BY country;

/*
Gold Result:
('Australia',)
('Brazil',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Brazil',)
*/