-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1, 'sta_6f4fb6', -55602865, 'sta_28275f', 'sta_3bc0d3', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'swwqcgsk', 1610062532, 'pgu7vfe4', 'hria2ypuzhs', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'rwbbp6luhvd', -1377057208, 'ilbnp', NULL, 1236688122);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483645, NULL, 2087640001, 'dposiie5unw', 'klfa9000t', 1408123494);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483644, '4', NULL, 'ecigce376n', 'um5', 742285925);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483643, 'u', -1179823637, NULL, 'rqro', 775304493);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (2, 'qyp5s5bbp0', 743312762, 'eutliqa11r', 'ytoo3o9', -1666765085);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (3, '72klex14ji7z', -2081315180, '2dwyrq13pyu7', 'd99rljsl0', -2031361952);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (4, 'p5qi2rk', -705985602, 'x58pz0f8je', 'd2', 1675430660);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (5, 'y9uxj4', -1612443122, 'd', 'lph2gn', 1968874827);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (6, 'nqcx5h', -1245312912, 'rjtu', 'dz79fjg', -1255130038);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (7, '3d', 513454646, '0gcb98', 'zk3z', 1686459626);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (8, 'lyr', 1038566008, 'n6vck6ah0f', 'jswwlq7xb', 602161869);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (9, 'xa', 1294666887, 'fdrz16n', 'jja', -7597509);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.capacity AS capacity, LHS.city AS city, LHS.country AS country, LHS.opening_year AS opening_year FROM stadium AS LHS INNER JOIN (SELECT id, name, MAX(capacity) OVER () AS capacity, city, country, opening_year FROM stadium) AS RHS ON (LHS.id = RHS.id AND LHS.name = RHS.name AND LHS.capacity = RHS.capacity AND LHS.city = RHS.city AND LHS.country = RHS.country AND LHS.opening_year = RHS.opening_year)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/