-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (12, '14', '14', 14, '14', '14', '14', '14', '14', '14', '14');
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (11, '14', '14', 14, '14', '14', '14', '14', '14', '14', '14');
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (14, '18', 887, NULL, '21', NULL);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (13, '36', 179, '20', '22', 24);
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (16, 14, '14', '14');
INSERT INTO "record" ("swimmer_id", "event_id", "id", "result") VALUES (11, 16, 14, '14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, capacity, city, country, opening_year, AVG(capacity) OVER () AS meancapacity FROM stadium) WHERE (meancapacity > capacity) ORDER BY name;

/*
Gold Result:
('36',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE capacity < (SELECT AVG(capacity) FROM stadium);

/*
Prediction Result:
('36',)
*/