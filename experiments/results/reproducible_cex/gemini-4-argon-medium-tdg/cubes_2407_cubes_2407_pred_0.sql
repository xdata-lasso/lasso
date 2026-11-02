-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Charlie', 'USA', 50.5, '1:45', '2:40', '3:35', '4:30', '5:25', '6:20', '7:15');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Alice', 'UK', 60.0, '1:50', '2:45', '3:40', '4:35', '5:30', '6:25', '7:20');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (3, 'Bob', 'AUS', 55.2, '1:48', '2:42', '3:38', '4:32', '5:28', '6:22', '7:18');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (4, 'Alice', 'CAN', 52.1, '1:46', '2:41', '3:36', '4:31', '5:26', '6:21', '7:16');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Olympic Pool', 10000, 'London', 'UK', 2012);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'National Aquatic', 15000, 'Sydney', 'AUS', 2000);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, '100m Freestyle', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 2, '200m Butterfly', '2021');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 1, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 2, 2, 'Loss');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (3, 1, 3, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM swimmer ORDER BY name, swimmer.id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM swimmer ORDER BY meter_100, swimmer.id NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Bob',)
('Alice',)
*/