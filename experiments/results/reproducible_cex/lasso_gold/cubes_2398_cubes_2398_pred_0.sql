-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1001, 'Allison Hill', 1005, 'New Jamesside', 'Fiji', 1009);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1002, 'Noah Rhodes', 1012.0, 'Robinsonshire', 'Cape Verde', 1022.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1003, 'Angie Henderson', 1019.0, 'Lisatown', 'Cuba', 1035.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1004, 'Daniel Wagner', 1026.0, 'Lake Roberto', 'Serbia', 1048.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM stadium ORDER BY opening_year, stadium.id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/