-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Stadium A', 1000, 'City A', 'Country A', 2000);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Event 1', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 1, 'Event 2', '2020');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, LHS.maxyear AS maxyear, RHS.id AS id_other, RHS.name AS name_other, RHS.stadium_id AS stadium_id_other, RHS.year AS year_other, RHS.maxyear AS maxyear_other FROM (SELECT id, name, stadium_id, YEAR, MAX(YEAR) OVER () AS maxyear FROM event) AS LHS CROSS JOIN (SELECT id, name, stadium_id, YEAR, MAX(YEAR) OVER () AS maxyear FROM event) AS RHS) WHERE (YEAR = maxyear AND maxyear = maxyear_other) ORDER BY name;

/*
Gold Result:
('Event 1',)
('Event 2',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Event 1',)
*/