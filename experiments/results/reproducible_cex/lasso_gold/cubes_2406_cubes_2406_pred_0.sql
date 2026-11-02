-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1018, 'Bobby Hall', 1019, 'South Joshuastad', 'Central African Republic', 1020);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1022, 'Andrea Reid', 1023, 'East Steven', 'Faroe Islands', 1024);
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (1021, 1018, 'Daniel Adams', 'write');
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (1025, 1022, NULL, 'threat');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM event ORDER BY name, event.id NULLS LAST;

/*
Gold Result:
(None,)
('Daniel Adams',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST;

/*
Prediction Result:
('Daniel Adams',)
(None,)
*/