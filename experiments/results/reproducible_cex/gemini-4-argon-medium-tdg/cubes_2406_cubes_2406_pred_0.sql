-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (1, 'Olympic Pool', 5000, 'London', 'UK', 2012);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (2, 'Aquatic Center', 8000, 'Tokyo', 'Japan', 2020);
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (10, 2, 'Freestyle', '2021');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (2, 1, 'Backstroke', '2022');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (5, 1, 'Backstroke', '2019');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (1, 2, 'Butterfly', '2020');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM event ORDER BY name, event.id NULLS LAST;

/*
Gold Result:
('Backstroke',)
('Backstroke',)
('Butterfly',)
('Freestyle',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST;

/*
Prediction Result:
('Backstroke',)
('Freestyle',)
('Butterfly',)
('Backstroke',)
*/