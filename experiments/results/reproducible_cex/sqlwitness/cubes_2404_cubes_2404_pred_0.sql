-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (1, 'default2', 1, 'default1', 'default1', 0), (0, 'default1', 1, NULL, NULL, 1), (2, 'default1', 1, 'default2', 'default2', 1), (3, 'default2', 1, NULL, 'default2', 1), (4, 'default2', 0, 'default2', 'default2', 0), (5, 'default2', 2, 'default1', 'default2', 0), (6, 'default2', 2, NULL, NULL, 1);
INSERT INTO event (id, stadium_id, name, year) VALUES (1, 4, 'default1', 'default2'), (0, 4, NULL, 'default2'), (2, 4, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM event ORDER BY id DESC) LIMIT 1);

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/