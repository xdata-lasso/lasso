-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (10, 'Michael Phelps', 'USA', 50.1, '90.0', '90.0', '90.0', '90.0', '10.0', '90.0', '90.0');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (20, 'Ian Thorpe', 'Australia', 48.5, '10.0', '10.0', '10.0', '10.0', '80.5', '10.0', '10.0');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (30, 'Caeleb Dressel', 'Brazil', 47.0, '50.0', '50.0', '50.0', '50.0', '50.0', '50.0', '50.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, id AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, TIME, COUNT(*) OVER () AS n FROM swimmer) ORDER BY meter_600 DESC) LIMIT 1);

/*
Gold Result:
('Australia', 20)
*/

-- Prediction Query
SELECT nationality, COUNT(*) FROM swimmer GROUP BY nationality HAVING COUNT(*) > 1;

/*
Prediction Result:
*/