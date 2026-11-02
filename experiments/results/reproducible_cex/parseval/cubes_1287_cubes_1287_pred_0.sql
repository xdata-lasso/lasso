-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1, 'cin_07fc1d', -55602865, -59984348, 'cin_4e4095');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (2, 'cin_07fc1d', -664303813, -1022641847, 'cin_4e4095');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (3, 'cin_07fc1d', -1726781632, 247012447, 'cin_4e4095');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (0, 'cin_488a5b', -1980249628, 0, 'cin_910acc');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (-2147483644, 'cin_488a5b', -734455130, 0, 'cin_910acc');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (4, NULL, -55602865, -59984348, 'wqcgsk');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (5, '9n8c4pgu7v', -1865039888, 1160656988, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM (SELECT * FROM (SELECT * FROM cinema ORDER BY LOCATION DESC, cinema.cinema_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None, 'wqcgsk')
*/

-- Prediction Query
SELECT name, LOCATION FROM cinema ORDER BY capacity DESC, cinema.cinema_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('9n8c4pgu7v', None)
*/