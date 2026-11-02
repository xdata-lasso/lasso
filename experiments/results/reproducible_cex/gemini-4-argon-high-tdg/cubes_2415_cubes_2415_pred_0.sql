-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Alex', 'USA', 48.5, '1:45.0', '2:45.0', '3:45.0', '4:45.0', '5:45.0', '6:45.0', '48.5');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'National Aquatics', 10000, 'Madrid', 'Spain', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'National Aquatics', 10000, 'Madrid', 'Spain', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, NULL, NULL, NULL, NULL, 1998);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Parc Olympique', 20000, 'Paris', 'France', 2006);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Europa Arena', 30000, 'Berlin', 'Germany', 2007);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Foro Italico', 15000, 'Rome', 'Italy', NULL);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 1, 'Spring Meet', '2004');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 1, 'Summer Meet', '2008');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (3, 4, 'Winter Finals', '2002');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 1, 1, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_city_ FROM stadium WHERE (opening_year < 2006) ORDER BY count_distinct_city_;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM stadium WHERE opening_year < 2006;

/*
Prediction Result:
(1,)
*/