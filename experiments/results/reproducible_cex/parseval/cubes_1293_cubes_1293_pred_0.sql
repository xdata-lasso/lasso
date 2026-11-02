-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483648, '5k5swwqcgs', 1, 247012447, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483647, '8c4pgu7vfe', 1, -1633151678, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483646, 'a2y', 1, 1115440883, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483645, 'hsrwbbp', 1, 13244799, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483644, 'hvdltt', 1, -1610064545, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483643, 'n', 1, 462974032, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483642, 'posiie5unw6k', 1, 1151980946, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483641, 'a9', 1, 1620389964, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483640, '00t5c4ecigc', 1, 528680845, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483639, '76nium52', 1, -443340271, NULL);

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483638, 'uo4nrqrofqy', 1, -1106983592, NULL);

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483637, '5bbp0', 1, 743312762, NULL);

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483636, 'eutliqa11r', NULL, 2137741668, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483635, 'ytoo3o9hl7', NULL, 1178636309, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483634, 'ex1', NULL, -74849714, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483633, '7zw', 1, 481163439, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483632, '2dwyrq', 1, -1097120355, 'cin_1f4f85');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483631, '78d99r', 1, -1362461264, 'cin_1f4f85');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LOCATION, openning_year, COUNT(*) AS n FROM cinema GROUP BY LOCATION, openning_year) WHERE (n = 300 OR n <> 1) ORDER BY LOCATION;

/*
Gold Result:
(None,)
('cin_1f4f85',)
('cin_1f4f85',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema WHERE capacity > 300 GROUP BY LOCATION HAVING COUNT(*) > 1;

/*
Prediction Result:
('cin_1f4f85',)
*/