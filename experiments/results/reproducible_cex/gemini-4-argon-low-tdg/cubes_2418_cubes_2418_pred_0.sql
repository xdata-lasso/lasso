-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (1, 'Arena A', 5000, 'CityA', 'CountryA', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (2, 'Arena B', 2010, 'CityB', 'CountryB', 2010);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (3, 'Arena C', 1000, 'CityC', 'CountryC', 2000);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (4, 'Arena D', 1000, 'CityD', 'CountryD', 2005);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (5, 'Arena E', 3000, 'CityE', 'CountryE', 2004);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (6, 'Arena F', 3000, 'CityF', 'CountryF', 2006);
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (7, 'Arena G', 2001, 'CityG', 'CountryG', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meancapacity AS avg_capacity_ FROM (SELECT AVG(capacity) AS meancapacity FROM (SELECT * FROM stadium WHERE (opening_year = 2005 OR opening_year >= capacity))) ORDER BY avg_capacity_;

/*
Gold Result:
(2252.5,)
*/

-- Prediction Query
SELECT AVG(capacity) FROM stadium WHERE opening_year = 2005;

/*
Prediction Result:
(3000.0,)
*/