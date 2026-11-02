-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality: duplicate locations, out-of-order insertion, and cinemas with/without schedules.
-- Catches mutants missing DISTINCT, missing ORDER BY, using DESC, or erroneously joining the schedule table.
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (1, 1, 1, 'Pilot', 'Director A', '2020-01-01', 'P01');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (1, 'Metro Cinema', 1995, 300, 'Chicago');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (2, 'Grand Theater', 2010, 500, 'Austin');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (3, 'City Plex', 2005, 150, 'Chicago');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (4, 'Starlight', 2018, 250, 'Boston');
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (1, 1, '2023-05-01', 4, 12.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM cinema ORDER BY LOCATION;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM cinema;

/*
Prediction Result:
('Chicago',)
('Austin',)
('Boston',)
*/