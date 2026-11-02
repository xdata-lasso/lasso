-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (cinema_id, name, openning_year, capacity, location) VALUES (0, 'default1', 0, 1, 'default2'), (1, 'default2', NULL, 0, 'default2'), (2, 'default2', 0, NULL, NULL), (3, NULL, NULL, 1, 'default1'), (4, NULL, 0, 1, 'default1');
INSERT INTO film (film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code) VALUES (0, NULL, 1, 'default2', NULL, 'default2', NULL), (1, 1, 1, 'default1', NULL, NULL, NULL), (2, NULL, 0, 'default2', NULL, 'default1', 'default1'), (3, 1, 0, NULL, NULL, 'default2', 'default1'), (4, 0, 1, 'default1', 'default1', 'default2', 'default1');
INSERT INTO schedule (cinema_id, film_id, date, show_times_per_day, price) VALUES (3, 2, 'default2', 0, 1.0), (2, 2, NULL, NULL, 0.0), (0, 2, NULL, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sumshow_times_per_day AS sum_t1_show_times_per_day_ FROM (SELECT LHS.cinema_id AS cinema_id, LHS.sumshow_times_per_day AS sumshow_times_per_day, RHS.name AS name, RHS.openning_year AS openning_year, RHS.capacity AS capacity, RHS.location AS LOCATION FROM (SELECT cinema_id, SUM(show_times_per_day) AS sumshow_times_per_day FROM schedule GROUP BY cinema_id) AS LHS INNER JOIN cinema AS RHS ON (LHS.cinema_id = RHS.cinema_id)) ORDER BY name, sum_t1_show_times_per_day_ NULLS LAST;

/*
Gold Result:
(None, 0)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT T2.name, SUM(T1.show_times_per_day) FROM schedule AS T1 JOIN cinema AS T2 ON T1.cinema_id = T2.cinema_id GROUP BY T1.cinema_id;

/*
Prediction Result:
('default1', None)
('default2', None)
(None, 0)
*/