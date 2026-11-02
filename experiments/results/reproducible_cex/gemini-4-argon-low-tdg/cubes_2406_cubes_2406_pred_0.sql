-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering, anti-Correlation with ID/Stadium_ID/Year, and unreferenced events (no records).
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (10, 'National Aquatics Center', 17000, 'Beijing', 'China', 2008);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (20, 'London Aquatics Centre', 17500, 'London', 'UK', 2011);
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (1, 20, 'Zebra Relay', '2000');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (2, 10, 'Mid Medley', '2024');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (3, 10, 'Alpha Sprint', '2012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM event ORDER BY name, event.id NULLS LAST;

/*
Gold Result:
('Alpha Sprint',)
('Mid Medley',)
('Zebra Relay',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST;

/*
Prediction Result:
('Mid Medley',)
('Alpha Sprint',)
('Zebra Relay',)
*/