-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Alpha Arena', 5000, 'Boston', 'USA', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Beta Bowl', 8000, 'Chicago', 'USA', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Alpha Arena', 6000, 'Austin', 'USA', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Gamma Dome', 12000, 'Denver', 'USA', 2015);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (10, 1, 'Winter Splash', '2002');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (20, 1, 'Summer Finals', '2004');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (30, 4, 'Spring Open', '2015');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (100, 'John Doe', 'USA', 48.5, '1:45', '2:45', '3:45', '4:45', '5:45', '6:45', '2002');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (100, 10, 1, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, capacity, city, country, opening_year, id_other, name_other, YEAR, id AS stadium_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year, RHS.id AS id_other, RHS.name AS name_other, RHS.year AS YEAR FROM stadium AS LHS INNER JOIN event AS RHS ON (LHS.id = RHS.stadium_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.opening_year = RHS.opening_year))) ORDER BY name;

/*
Gold Result:
('Alpha Arena',)
('Beta Bowl',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE NOT id IN (SELECT stadium_id FROM event);

/*
Prediction Result:
('Beta Bowl',)
('Alpha Arena',)
*/