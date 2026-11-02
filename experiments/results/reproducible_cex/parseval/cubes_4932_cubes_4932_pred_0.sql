-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'hria2ypu', 1644814318, 'sr', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'wbbp6luhvdlt', -841692980, 'bnp', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483645, 'mdpos', -1576219117, '5u', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483644, 'w6kl', 1620389964, '00t5c4ecigc', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483643, 'e376nium52', -443340271, 'uo4nrqrofqy', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483642, '5s5b', 2107872094, '02eutliqa11r', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483641, 'ytoo3o9', -1666765085, '72klex14ji7z', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483640, 'au2dwy', -953437896, '3pyu78d', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483639, '9rljsl0b4', 1649269347, 'p5qi2rkf9v', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483638, 'x58pz', -1529584866, 'd2', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483637, 'vy9uxj4', -1612443122, 'd', NULL, 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483636, 'lph2gn', 1968874827, 'nqcx5h', 'sta_749fe6', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483635, 'cprj', -841004020, 'dz79fjg', 'sta_749fe6', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483634, '8n2f3', 806170397, 'qv0gcb98ozk', 'sta_749fe6', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483633, 'zbilyrkn', -688098735, '6ah', 'sta_e032bc', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483632, 'f8jswwl', 1255343543, '7', 'sta_e032bc', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483631, '2fxa7ryfdrz', 61479715, 'jja', 'sta_e032bc', NULL);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483630, '5dh', 1583472758, 'rg', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483629, 'd8y', 1129658414, '1afgo', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483628, 'ri', -902895762, 'ayxp1q43', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483627, '1jh3den', 357330522, '68x8vacx7a', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483626, 'u5', -290314193, 'f77pzo72ctd', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483625, 't', -1284905200, '62', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483624, '0v', 820970595, 'qdjpe1io2', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483623, '78507cvt', -1523347137, 'ttg6bnou5zi3', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483622, 'c4bfkfoac', -406331049, 'ezjo7wg', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483621, 'd5ysxc', -405743609, 'g', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483620, '5i3', -1405314653, '5lnpim5k58qs', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483619, '7p2r94gt', 1273687251, '2mnajjla3o', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483618, 'v8u', 618058035, '2ne578', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483617, 'fvy', -451030047, 'be8yvkv42q7', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483616, 'x58b4', -1122409769, 'u', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483615, '3auvm', 274891948, 'pdjwzw5chn9', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483614, 'o705', 238533676, 'jxfofws', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483613, 'do2zobb', -397848196, '0k32odwcl5a', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483612, 'msorlwyngc', -323362455, 'j9erhizgk1', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483611, 'yoeyo6l0hdt6', 1435223075, 'qyxuzk', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483610, '5', -206528034, 'wn', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483609, 'as6', -2076274980, 'ow', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483608, 'i1z', -564679000, '66', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483607, 'q2xlyoto', 1774679448, 'oaawg96aq', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483606, '0', -850941333, 'indz39tajz', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483605, 'td8n5wcgu', -1275298282, '3', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483604, 'tdu6bd0w96', -379749892, 'vzxw1rxe9y', 'sta_749fe6', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483603, 'k7', -1046720861, '162nh55y3d', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483602, 'ohvu06dza3', 1595632888, 'mkio18ri2hy', 'sta_e032bc', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483601, '08ftp6ewtqxx', 1664452437, 'jabymzn2mfx7', 'sta_e032bc', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT * FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT MAX(n) AS n FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year)) AS RHS WHERE (LHS.n = RHS.n))) ORDER BY country;

/*
Gold Result:
('sta_749fe6',)
('sta_e032bc',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('sta_749fe6',)
*/