-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1027, 'Maria Lynch', 1028, 1029, '76483 Cameron Trail
East Lydiamouth, MO 35594');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1035, 'Emily Rios', 1036, 1037, '42388 Burgess Meadow Suite 532
Daviston, VI 14872');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1030, 1031, 1032, 'Brewing technologist', 'development', 'white', 'yes');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1038, 1039, 1040, 'Designer, ceramics/pottery', 'product', 'collection', 'structure');
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1027, 1030, 'our', 1033, 1034.5);
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1035, 1038, 'response', NULL, 1042.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sumshow_times_per_day AS sum_t1_show_times_per_day_ FROM (SELECT LHS.cinema_id AS cinema_id, LHS.sumshow_times_per_day AS sumshow_times_per_day, RHS.name AS name, RHS.openning_year AS openning_year, RHS.capacity AS capacity, RHS.location AS LOCATION FROM (SELECT cinema_id, SUM(show_times_per_day) AS sumshow_times_per_day FROM schedule GROUP BY cinema_id) AS LHS INNER JOIN cinema AS RHS ON (LHS.cinema_id = RHS.cinema_id)) ORDER BY name, sum_t1_show_times_per_day_ NULLS LAST;

/*
Gold Result:
('Emily Rios', None)
('Maria Lynch', 1033)
*/

-- Prediction Query
SELECT T2.name, SUM(T1.show_times_per_day) FROM schedule AS T1 JOIN cinema AS T2 ON T1.cinema_id = T2.cinema_id GROUP BY T1.cinema_id;

/*
Prediction Result:
('Maria Lynch', 1033)
('Emily Rios', None)
*/