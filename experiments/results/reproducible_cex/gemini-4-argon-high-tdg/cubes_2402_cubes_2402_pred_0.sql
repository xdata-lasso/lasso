-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (50, 'Cairo Arena', 15000, 'Cairo', 'Egypt', 2001);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (51, 'Alexandria Pool', 12000, 'Alexandria', 'Egypt', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (52, 'Giza Center', 10000, 'Giza', 'Egypt', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (53, 'Luxor Aquatics', 8000, 'Luxor', 'Egypt', 2012);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (40, 'Copenhagen Dome', 9000, 'Copenhagen', 'Denmark', 1998);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (41, 'Aarhus Pool', 7000, 'Aarhus', 'Denmark', 2003);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (42, 'Odense Water', 6000, 'Odense', 'Denmark', 2008);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (20, 'Rio Aquatics', 18000, 'Rio', 'Brazil', 2015);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (21, 'Sao Paulo Pool', 14000, 'Sao Paulo', 'Brazil', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (10, 'Toronto Center', 11000, 'Toronto', 'Canada', 2014);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (30, 'Buenos Aires Arena', 13000, 'Buenos Aires', 'Argentina', 1995);
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Jean', 'France', 48.5, '1:45', '2:45', '3:45', '4:45', '5:45', '6:45', '2020');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Lars', 'Denmark', 49.1, '1:46', '2:46', '3:46', '4:46', '5:46', '6:46', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (101, 10, 'Spring Open', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (102, 10, 'Summer Cup', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (103, 10, 'Winter Meet', '2022');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (104, 20, 'South Finals', '2021');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (105, 40, 'Nordic Trophy', '2021');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 101, 1, 'Win');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (2, 105, 2, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM stadium GROUP BY country) WHERE (n < 3) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Brazil',)
('Canada',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country HAVING COUNT(*) <= 3;

/*
Prediction Result:
('Argentina',)
('Brazil',)
('Canada',)
('Denmark',)
*/