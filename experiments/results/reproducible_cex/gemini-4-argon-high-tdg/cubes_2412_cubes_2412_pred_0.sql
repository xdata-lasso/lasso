-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (15, 'Liam', 'Canada', 52.1, '1:48.00', '2:45.00', '3:42.00', '4:40.00', '6:45.10', '7:10.00', '8:05.00');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (25, 'Noah', 'UK', 49.5, '1:42.00', '2:38.00', '3:35.00', '5:55.00', '5:10.00', '8:50.00', '9:45.00');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (35, 'Oliver', 'China', 58.9, '1:59.00', '2:58.00', '3:59.00', '4:50.00', '6:20.00', '7:20.00', '8:15.00');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (45, 'Zack', 'USA', 50.2, '1:45.00', '2:40.00', '3:38.00', '4:35.00', '5:40.00', '6:50.00', '7:55.00');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Aquatic Center', 15000, 'London', 'UK', 2011);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (101, 1, 'World Finals', '2020');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (25, 101, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (35, 101, 2, 'Place');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (45, 101, 3, 'Show');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, id AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, TIME, COUNT(*) OVER () AS n FROM swimmer) ORDER BY meter_600 DESC) LIMIT 1);

/*
Gold Result:
('Canada', 15)
*/

-- Prediction Query
SELECT nationality, COUNT(*) FROM swimmer GROUP BY nationality HAVING COUNT(*) > 1;

/*
Prediction Result:
*/