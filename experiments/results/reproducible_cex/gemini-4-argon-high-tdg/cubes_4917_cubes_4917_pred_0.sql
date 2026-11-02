-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Zeta Water Park', 80000, 'London', 'UK', 2015);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Midway Natatorium', 50000, 'Paris', 'France', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Alpha Aquatics', 80000, 'Tokyo', 'Japan', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Delta Dome', 80000, 'Sydney', 'Australia', 2000);
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Alice Smith', 'UK', 52.1, '1:55.0', '2:55.0', '3:55.0', '4:55.0', '5:55.0', '6:55.0', '2021-05-10');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Bob Jones', 'Japan', 49.3, '1:48.0', '2:48.0', '3:48.0', '4:48.0', '5:48.0', '6:48.0', '2021-05-11');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Spring Meet', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 1, 'Summer Finals', '2022');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 3, 'Winter Cup', '2020');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Gold');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 2, 2, 'Silver');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 3, 3, 'Gold');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year FROM stadium AS LHS INNER JOIN (SELECT id, name, MAX(capacity) OVER () AS capacity, city, country, opening_year FROM stadium) AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name AND LHS.capacity = RHS.capacity AND LHS.city = RHS.city AND LHS.country = RHS.country AND LHS.opening_year = RHS.opening_year)) ORDER BY name;

/*
Gold Result:
('Alpha Aquatics',)
('Delta Dome',)
('Zeta Water Park',)
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Water Park',)
*/