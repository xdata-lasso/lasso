-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (9, 14, 14, '14', '14', '14', '14');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (8, 14, 14, '14', '14', '14', '14');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (11, '14', 12, -24, '14');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (10, '15', 12, 891, '14');
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (10, 8, '14', 14, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LOCATION, openning_year, COUNT(*) AS n FROM cinema GROUP BY LOCATION, openning_year) WHERE (n = 300 OR n <> 1) ORDER BY LOCATION;

/*
Gold Result:
('14',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema WHERE capacity > 300 GROUP BY LOCATION HAVING COUNT(*) > 1;

/*
Prediction Result:
*/