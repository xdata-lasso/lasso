-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by name, duplicate names (to catch DISTINCT/GROUP BY mutants), and NULL names (to catch WHERE name IS NOT NULL or NULLS LAST on name).
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (3, 'Charlie', 'UK', 50.1, '1:48.0', '2:45.0', '3:42.0', '4:40.0', '5:38.0', '6:35.0', '7:30.0');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Alice', 'USA', 51.2, '1:49.0', '2:46.0', '3:43.0', '4:41.0', '5:39.0', '6:36.0', '7:31.0');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (4, 'Alice', 'Canada', 52.0, '1:50.0', '2:47.0', '3:44.0', '4:42.0', '5:40.0', '6:37.0', '7:32.0');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Bob', 'Australia', 49.5, '1:47.0', '2:44.0', '3:41.0', '4:39.0', '5:37.0', '6:34.0', '7:29.0');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (5, NULL, 'France', 53.0, '1:51.0', '2:48.0', '3:45.0', '4:43.0', '5:41.0', '6:38.0', '7:33.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM swimmer ORDER BY name, swimmer.id NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM swimmer ORDER BY meter_100, swimmer.id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Charlie',)
('Alice',)
('Alice',)
(None,)
*/