-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'hsrwbbp', 13244799, 'hvdltt', 'lbn', 2006);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'rmdp', 2026480202, 'ie5', 'nw6klf', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (2, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (3, 'hsrwbbp', 13244799, 'hvdltt', 'lbn', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (4, 'rmdp', 2026480202, 'ie5', 'nw6klf', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (5, 'a9000t5c4eci', 1149850321, 'e', '76nium52', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (6, 'zbuo4nrqrof', 373262291, 'p5s5bbp', '02eutliqa11r', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (7, 'ytoo3o9', -1666765085, '72klex14ji7z', 'au2dwy', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (8, 'q13py', 244829661, 'jsl', 'b4yp5qi', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (9, 'rkf9vqx5', 1836127587, 'f8jegd2', 'vy9uxj4', 2005);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (10, 'wb', -1929953647, 'ph2', 'nd', 2005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_city_ FROM stadium WHERE (opening_year < 2006) ORDER BY count_distinct_city_;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM stadium WHERE opening_year < 2006;

/*
Prediction Result:
(9,)
*/