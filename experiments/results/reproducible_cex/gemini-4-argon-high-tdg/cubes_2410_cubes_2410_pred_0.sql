-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Zeta Arena', 5000, 'Madrid', 'Spain', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Alpha Pool', 8000, 'Berlin', 'Germany', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Gamma Center', 3000, 'Rome', 'Italy', 1995);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Beta Dome', 6000, 'Paris', 'France', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Delta Aquatic', 9000, 'London', 'UK', 2015);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 2, 'Spring Meet', '2010');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 4, 'Summer Finals', '2012');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (4, 4, 'Winter Cup', '2014');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, capacity, city, country, opening_year, id_other, name_other, YEAR, id AS stadium_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year, RHS.id AS id_other, RHS.name AS name_other, RHS.year AS YEAR FROM stadium AS LHS INNER JOIN event AS RHS ON (LHS.id = RHS.stadium_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.opening_year = RHS.opening_year))) ORDER BY name;

/*
Gold Result:
('Delta Aquatic',)
('Gamma Center',)
('Zeta Arena',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE NOT id IN (SELECT stadium_id FROM event);

/*
Prediction Result:
('Zeta Arena',)
('Gamma Center',)
('Delta Aquatic',)
*/