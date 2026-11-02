-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Aquatic Palace', 15000, 'Sydney', 'Australia', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Water Cube', 17000, 'Beijing', 'China', 2008);
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Michael', 'USA', 47.5, '1:42.0', '2:40.0', '3:40.0', '4:40.0', '5:40.0', '6:40.0', '2022');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Ian', 'Australia', 48.1, '1:44.0', '2:42.0', '3:41.0', '4:42.0', '5:43.0', '6:45.0', '2018');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Warmup', '2018');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 1, 'Semifinal', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 2, 'Synchronized', '2022');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (4, 1, 'Backstroke', '2022');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (5, 2, 'Backstroke', '2022');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (6, 2, 'Freestyle', '2022');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 2, 2, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 3, 3, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 4, 4, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, LHS.maxyear AS maxyear, RHS.id AS id_other, RHS.name AS name_other, RHS.stadium_id AS stadium_id_other, RHS.year AS year_other, RHS.maxyear AS maxyear_other FROM (SELECT id, name, stadium_id, YEAR, MAX(YEAR) OVER () AS maxyear FROM event) AS LHS CROSS JOIN (SELECT id, name, stadium_id, YEAR, MAX(YEAR) OVER () AS maxyear FROM event) AS RHS) WHERE (YEAR = maxyear AND maxyear = maxyear_other) ORDER BY name;

/*
Gold Result:
('Backstroke',)
('Freestyle',)
('Synchronized',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Synchronized',)
*/