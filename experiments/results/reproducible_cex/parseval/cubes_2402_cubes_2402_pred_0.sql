-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'sta_ed7479', -1633151678);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'a2y', 1115440883, 'hsrwbbp', 'sta_ed7479', 13244799);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'hvdltt', -1610064545, 'n', 'sta_ed7479', 462974032);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483645, 'posiie5unw6k', 1151980946, 'a9', 'sta_ed7479', 1620389964);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483644, '00t5c4ecigc', 528680845, '76nium52', 'sta_ed7479', -443340271);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483643, 'uo4nrqrofqy', -1106983592, '5bbp0', 'sta_ed7479', 743312762);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483642, 'eutliqa11r', 2137741668, 'ytoo3o9hl7', 'sta_ed7479', 1178636309);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483641, 'ex1', -74849714, '7zw', 'sta_ed7479', 481163439);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483640, '2dwyrq', -1097120355, '78d99r', 'sta_ed7479', -1362461264);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483639, 'l0b4y', -1116181514, 'i2rkf', NULL, 222415430);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483638, 'x58pz', -1529584866, 'd2', NULL, 1675430660);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483637, 'y9uxj4', -1612443122, 'd', NULL, -736979194);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483636, 'h2gn', 1968874827, 'nqcx5h', 'sta_ed7479', -1245312912);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483635, 'rjtu', -361507387, '79fjgq8', 'sta_ed7479', -1255130038);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483634, '3d', 513454646, '0gcb98', 'sta_ed7479', -1454058168);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, COUNT(*) AS n FROM stadium GROUP BY country) WHERE (n < 3) ORDER BY country;

/*
Gold Result:
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country HAVING COUNT(*) <= 3;

/*
Prediction Result:
(None,)
*/