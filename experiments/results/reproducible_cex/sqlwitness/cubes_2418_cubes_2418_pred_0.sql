-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (2006, NULL, 1, NULL, 'default1', 2006), (1, 'default1', 2004, 'default2', 'default1', 2004), (2004, NULL, 0, 'default1', 'default1', NULL), (2005, 'default1', 1, 'default2', 'default2', NULL), (0, NULL, 2005, 'default2', 'default1', 2005), (2, 'default1', 0, NULL, 'default2', NULL), (3, 'default2', 2004, 'default1', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meancapacity AS avg_capacity_ FROM (SELECT AVG(capacity) AS meancapacity FROM (SELECT * FROM stadium WHERE (opening_year = 2005 OR opening_year >= capacity))) ORDER BY avg_capacity_;

/*
Gold Result:
(1336.6666666666667,)
*/

-- Prediction Query
SELECT AVG(capacity) FROM stadium WHERE opening_year = 2005;

/*
Prediction Result:
(2005.0,)
*/