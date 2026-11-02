-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Aquatic Center', 15000, 'London', 'UK', 2011);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Water Cube', 17000, 'Beijing', 'China', 2007);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (10, 1, '100m Freestyle', '2012');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (20, 2, '200m Butterfly', '2008');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Zack', 'USA', 48.5, '1:45.0', '2:45.0', '3:45.0', '4:45.0', '5:45.0', '6:45.0', '48.50');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Alice', 'Australia', 52.1, '1:50.2', '2:50.2', '3:50.2', '4:50.2', '5:50.2', '6:50.2', '52.10');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (3, 'Bob', 'Canada', 49.9, '1:48.0', '2:48.0', '3:48.0', '4:48.0', '5:48.0', '6:48.0', '49.90');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (4, 'Alice', 'UK', 50.5, '1:49.0', '2:49.0', '3:49.0', '4:49.0', '5:49.0', '6:49.0', '50.50');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 10, 100, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 20, 101, 'Loss');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 10, 102, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM swimmer ORDER BY name, swimmer.id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM swimmer ORDER BY meter_100, swimmer.id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Bob',)
('Alice',)
('Alice',)
*/