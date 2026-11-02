-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (13, '797', '797', 797, '797', '797', '797', '797', '797', '797', '797');
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (12, '797', '797', 797, '797', '797', '797', '797', '797', '797', '797');
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (14, '797', 797, '797', '797', 797);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (17, '797', 797, '797', '797', 797);
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (16, 17, '18', '797');
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (15, 17, '18', '-635');
INSERT INTO "record" ("swimmer_id", "event_id", "id", "result") VALUES (13, 15, 797, '797');
INSERT INTO "record" ("swimmer_id", "event_id", "id", "result") VALUES (12, 15, 797, '797');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, LHS.maxyear AS maxyear, RHS.id AS id_other, RHS.name AS name_other, RHS.stadium_id AS stadium_id_other, RHS.year AS year_other, RHS.maxyear AS maxyear_other FROM (SELECT id, name, stadium_id, YEAR, MAX(YEAR) OVER () AS maxyear FROM event) AS LHS CROSS JOIN (SELECT id, name, stadium_id, YEAR, MAX(YEAR) OVER () AS maxyear FROM event) AS RHS) WHERE (YEAR = maxyear AND maxyear = maxyear_other) ORDER BY name;

/*
Gold Result:
('18',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('18',)
*/