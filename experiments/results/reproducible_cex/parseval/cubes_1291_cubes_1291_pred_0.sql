-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483648, '5k5swwqcgs', 247012447, -1980249628, 'cin_e7ec03');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483647, 'gu7v', -1865039888, 801, 'cin_c1fd2d');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (2, 'hria2ypuzhs', 700293388, 906324270, 'cin_e7ec03');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3, 'b', 1072996612, 13244799, 'cin_e7ec03');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483646, 'hvdltt', -1610064545, 801, 'cin_c1fd2d');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483643, 'n', 462974032, 801, 'cin_c368ca');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483642, 'posiie5unw6k', 1151980946, 1620389964, 'cin_e7ec03');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483641, '00t5c4ecigc', 528680845, -1585009206, 'cin_84b7ac');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483640, '52zb', 757448742, -1179823637, 'cin_e7ec03');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483639, 'rqro', 775304493, 800, 'cin_c1fd2d');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483638, 'qyp5s5bbp0', 743312762, -1822992503, NULL);

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483637, 'liqa1', 2074205376, 801, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT * FROM cinema AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM cinema WHERE (capacity >= 800)) AS RHS WHERE (LHS.location = RHS.location))) ORDER BY LOCATION;

/*
Gold Result:
(None,)
('cin_84b7ac',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema EXCEPT SELECT LOCATION FROM cinema WHERE capacity > 800;

/*
Prediction Result:
('cin_84b7ac',)
*/