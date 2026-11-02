-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (1, NULL, 2, NULL, 'default1', 1), (2, NULL, 2, 'default1', 'default2', 1), (0, 'default1', NULL, 'default1', NULL, NULL);
INSERT INTO event (id, stadium_id, name, year) VALUES (0, NULL, 'default2', 'default2'), (1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, capacity, city, country, opening_year, id_other, name_other, YEAR, id AS stadium_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year, RHS.id AS id_other, RHS.name AS name_other, RHS.year AS YEAR FROM stadium AS LHS INNER JOIN event AS RHS ON (LHS.id = RHS.stadium_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.opening_year = RHS.opening_year))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE NOT id IN (SELECT stadium_id FROM event);

/*
Prediction Result:
*/