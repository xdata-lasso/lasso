-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (1, 'Stadium A', 49999, 'City A', 'Zambia', 2000);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (2, 'Stadium B', 50000, 'City B', 'Argentina', 2001);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (3, 'Stadium C', 50001, 'City C', 'Brazil', 2002);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (4, 'Stadium D', 55000, 'City D', 'Canada', 2003);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (5, 'Stadium E', 59999, 'City E', 'Denmark', 2004);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (6, 'Stadium F', 60000, 'City F', 'Egypt', 2005);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (7, 'Stadium G', 65000, 'City G', 'France', 2006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM stadium WHERE (capacity < 60000 AND capacity <= 50000) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Zambia',)
*/

-- Prediction Query
SELECT country FROM stadium WHERE capacity > 60000 INTERSECT SELECT country FROM stadium WHERE capacity < 50000;

/*
Prediction Result:
*/