-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Aqua Dome', 1000, 'Berlin', 'Germany', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Blue Pool', 5000, 'Paris', 'France', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Civic Center', 1500, 'Rome', 'Italy', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Delta Arena', 1991, 'Madrid', 'Spain', 1991);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Echo Hall', 5000, 'Lisbon', 'Portugal', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Falcon Stadium', 2005, 'Vienna', 'Austria', 2004);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'Grand Basin', 3000, 'Zurich', 'Switzerland', 2006);
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Alex', 'USA', 48.5, '1:45', '2:45', '3:45', '4:45', '5:45', '6:45', '2005');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Finals', '2005');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 1, 'Semis', '2005');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 6, 'Qualifier', '2004');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meancapacity AS avg_capacity_ FROM (SELECT AVG(capacity) AS meancapacity FROM (SELECT * FROM stadium WHERE (opening_year = 2005 OR opening_year >= capacity))) ORDER BY avg_capacity_;

/*
Gold Result:
(2898.2,)
*/

-- Prediction Query
SELECT AVG(capacity) FROM stadium WHERE opening_year = 2005;

/*
Prediction Result:
(3666.6666666666665,)
*/