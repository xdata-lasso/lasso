-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (100, 'Aquatic Center', 5000, 'London', 'UK', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (200, 'Olympic Pool', 8000, 'Tokyo', 'Japan', 2018);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (300, 'Water Cube', 6000, 'Beijing', 'China', 2008);
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Michael', 'USA', 47.5, '1:42', '2:40', '3:40', '4:40', '5:40', '6:40', '2020');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Ian', 'Australia', 48.1, '1:44', '2:42', '3:42', '4:42', '5:42', '6:42', '2019');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 300, 'Zeta Sprint', '2024');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (5, 100, 'Alpha Relay', '2016');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (10, 200, 'Midway Medley', '2020');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 2, 50, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 5, 100, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM event ORDER BY id DESC) LIMIT 1);

/*
Gold Result:
('Midway Medley',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Sprint',)
*/