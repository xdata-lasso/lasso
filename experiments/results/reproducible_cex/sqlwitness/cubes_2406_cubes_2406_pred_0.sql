-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (0, NULL, 1, 'default2', 'default1', 0), (1, NULL, 0, 'default2', NULL, 1), (2, 'default2', NULL, 'default2', 'default1', NULL), (3, 'default1', 1, 'default2', 'default2', 0), (4, NULL, NULL, 'default2', 'default2', NULL);
INSERT INTO event (id, stadium_id, name, year) VALUES (0, 4, NULL, 'default2'), (1, 3, 'default2', 'default1'), (2, 1, NULL, NULL), (3, 2, 'default2', 'default1'), (4, 2, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM event ORDER BY name, event.id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
('default2',)
(None,)
*/