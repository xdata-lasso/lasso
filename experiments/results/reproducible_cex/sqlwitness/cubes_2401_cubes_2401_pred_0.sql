-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (id, name, capacity, city, country, opening_year) VALUES (2007, NULL, 2007, 'default1', NULL, 2), (2005, NULL, 1, NULL, 'default1', 2), (2006, 'default1', 2006, 'default2', NULL, 2007), (1, 'default1', 2006, 'default2', 'default2', 2005), (0, 'default1', 0, NULL, 'default2', 2005), (2, 'default2', 1, NULL, 'default1', 2007), (3, 'default2', NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM stadium WHERE (opening_year > 2006)) AS RHS WHERE (LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT country FROM stadium EXCEPT SELECT country FROM stadium WHERE opening_year > 2006;

/*
Prediction Result:
('default2',)
*/