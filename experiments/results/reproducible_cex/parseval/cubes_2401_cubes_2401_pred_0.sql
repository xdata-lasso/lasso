-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'sta_f18b9a', -1633151678);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'a2y', 1115440883, 'hsrwbbp', 'sta_3890f2', 2007);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (2, 'luhvdltti', -1364429300, 'nprmdposii', 'sta_f18b9a', -1823627488);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (3, 'nw6klf', 1038707349, '9000t5c4ec', 'sta_f18b9a', -1683203397);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'e376nium52', -443340271, 'uo4nrqrofqy', 'sta_3890f2', 2007);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483643, '5s5b', 2107872094, '02eutliqa11r', 'sta_72f61c', 2007);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483642, 'ytoo3o9', -1666765085, '72klex14ji7z', 'sta_f18b9a', -2081315180);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483641, '2dwyrq13pyu7', 244829661, 'jsl', 'sta_52f5c5', -346339240);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483640, 'yp5qi2rk', -705985602, 'x58pz0f8je', 'sta_f18b9a', 1196308825);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483639, 'd21vy9uxj4hw', -2050247126, 'lph2gn', 'sta_3890f2', 2006);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483638, 'q', -664193365, 'cx5hn', NULL, -1106350634);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483637, 'tu0', -1898531797, '9fjgq8n2f', NULL, 2007);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM stadium WHERE (opening_year > 2006)) AS RHS WHERE (LHS.country = RHS.country))) ORDER BY country;

/*
Gold Result:
(None,)
('sta_52f5c5',)
*/

-- Prediction Query
SELECT country FROM stadium EXCEPT SELECT country FROM stadium WHERE opening_year > 2006;

/*
Prediction Result:
('sta_52f5c5',)
*/