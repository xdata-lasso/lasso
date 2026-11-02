-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Michael Phelps', 'USA', 47.5, '1:42.9', '2:40.1', '3:40.2', '4:41.0', '5:42.1', '6:45.0', '2008');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Ian Thorpe', 'Australia', 48.1, '1:44.0', '2:41.5', '3:40.0', '4:42.3', '5:43.0', '6:46.2', '2004');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Zeta Arena', 100, 'Paris', 'France', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Alpha Dome', 200, 'Paris', 'France', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Beta Center', 300, 'London', 'UK', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Gamma Park', 400, 'London', 'UK', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Delta Field', 500, 'Berlin', 'Germany', 2015);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 2, 'Spring Meet', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 2, 'Winter Cup', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 5, 'Grand Finals', '2022');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 2, 2, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, capacity, city, country, opening_year, AVG(capacity) OVER () AS meancapacity FROM stadium) WHERE (meancapacity > capacity) ORDER BY name;

/*
Gold Result:
('Alpha Dome',)
('Zeta Arena',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE capacity < (SELECT AVG(capacity) FROM stadium);

/*
Prediction Result:
('Zeta Arena',)
('Alpha Dome',)
*/