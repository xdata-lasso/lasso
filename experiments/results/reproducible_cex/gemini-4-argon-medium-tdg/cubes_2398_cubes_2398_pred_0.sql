-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Opening_year ASC, anti-correlated with Capacity, City, Country, and ID to kill wrong sort column or DESC mutants.
-- Also includes only one stadium linked to an event to kill erroneous INNER JOIN mutants.
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Newest High Cap', 90000, 'Alpha', 'USA', 2020);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Middle Med Cap', 50000, 'Beta', 'UK', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Oldest Low Cap', 10000, 'Zeta', 'Canada', 1980);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'World Finals', '2022');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM stadium ORDER BY opening_year, stadium.id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Oldest Low Cap',)
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Newest High Cap',)
*/