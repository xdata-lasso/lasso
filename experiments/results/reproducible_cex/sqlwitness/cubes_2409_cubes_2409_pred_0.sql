-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO swimmer (id, name, nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, time) VALUES (1, 'default2', NULL, NULL, 'default2', 'Australia', 'default2', 'Australia', 'Australia', 'Australia', 'default2'), (0, NULL, 'Australia', 1.0, 'Australia', 'default2', NULL, 'default1', 'default2', 'Australia', 'default2'), (2, 'default1', 'default2', 0.0, 'default1', NULL, 'default1', 'default1', 'Australia', 'default1', NULL), (3, 'default1', 'Australia', NULL, NULL, 'default1', NULL, 'default2', 'default2', NULL, 'default2'), (4, 'default1', 'default2', 0.0, NULL, 'default2', 'Australia', NULL, 'default1', 'Australia', 'default2'), (5, 'Australia', 'default2', 0.0, 'Australia', NULL, 'default1', 'default2', 'default1', 'Australia', 'default1'), (6, 'Australia', 'default2', NULL, NULL, NULL, 'default1', 'default2', 'Australia', 'default2', 'default2'), (7, 'default1', NULL, 0.0, 'default1', 'default2', 'default2', NULL, 'Australia', NULL, 'Australia'), (8, 'Australia', 'default2', 0.0, 'default2', 'default1', 'Australia', 'default2', 'Australia', 'default1', NULL), (9, 'Australia', 'default1', 0.0, 'default2', 'default1', 'default1', 'default2', 'default1', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meter_200", "meter_300" FROM "swimmer" WHERE ("nationality" = 'Australia') ORDER BY meter_200, swimmer.id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('Australia', 'default2')
*/

-- Prediction Query
SELECT meter_200, meter_300 FROM swimmer WHERE nationality = 'Australia';

/*
Prediction Result:
('Australia', 'default2')
(None, 'default1')
*/