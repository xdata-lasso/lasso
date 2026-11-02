-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Michael', 'USA', 47.5, '1:42', '2:40', '3:40', '4:40', '5:40', '6:40', '47.5');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'West Arena', 10000, 'Los Angeles', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'East Arena', 10000, 'New York', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'North Arena', 10000, 'Chicago', 'USA', 2004);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'South Arena', 10000, 'Houston', 'USA', 2004);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Stade Un', 5000, 'Paris', 'France', 1998);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Stade Deux', 5000, 'Lyon', 'France', 1998);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'Stade Trois', 5000, 'Marseille', 'France', 1998);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (8, 'Tokyo Dome', 80000, 'Tokyo', 'Japan', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (9, 'Osaka Dome', 80000, 'Osaka', 'Japan', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (10, 'Maracana', 100000, 'Rio', 'Brazil', 2020);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 10, 'Qualifiers', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 10, 'Quarterfinals', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 10, 'Semifinals', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (4, 10, 'Finals', '2021');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 2, 2, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 3, 3, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 4, 4, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT * FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT MAX(n) AS n FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year)) AS RHS WHERE (LHS.n = RHS.n))) ORDER BY country;

/*
Gold Result:
('France',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/