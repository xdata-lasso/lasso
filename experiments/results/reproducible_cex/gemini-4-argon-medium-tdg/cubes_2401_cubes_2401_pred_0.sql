-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Opening_year and Country (distinguishes NOT EXISTS from NOT IN and direct <= 2006 filters).
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (1, 'Null Year Stadium', 20000, 'Metro', 'France', NULL);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (2, 'Null Country Old', 25000, 'Town', NULL, 2000);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (3, 'Null Country New', 30000, 'Village', NULL, 2008);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (4, 'Valid Old Stadium', 40000, 'Capital', 'Germany', 2006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM stadium WHERE (opening_year > 2006)) AS RHS WHERE (LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
(None,)
('France',)
('Germany',)
*/

-- Prediction Query
SELECT country FROM stadium EXCEPT SELECT country FROM stadium WHERE opening_year > 2006;

/*
Prediction Result:
('France',)
('Germany',)
*/