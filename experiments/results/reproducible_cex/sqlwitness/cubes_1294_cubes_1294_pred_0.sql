-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (cinema_id, name, openning_year, capacity, location) VALUES (2, 'default1', 0, NULL, NULL), (1, NULL, 0, 2, 'default1'), (0, NULL, 2, 1, 'default1');
INSERT INTO film (film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code) VALUES (0, 1, NULL, NULL, NULL, NULL, 'default2'), (1, 0, NULL, 'default1', 'default2', NULL, 'default1'), (2, 2, 2, NULL, 'default1', 'default2', 'default2');
INSERT INTO schedule (cinema_id, film_id, date, show_times_per_day, price) VALUES (0, 0, 'default2', 0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT directed_by FROM (SELECT film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code, film_id_other, date, show_times_per_day, price, number_in_season AS cinema_id FROM (SELECT LHS.film_id AS film_id, LHS.rank_in_series AS rank_in_series, LHS.number_in_season AS number_in_season, LHS.title AS title, LHS.directed_by AS directed_by, LHS.original_air_date AS original_air_date, LHS.production_code AS production_code, RHS.film_id AS film_id_other, RHS.date AS date, RHS.show_times_per_day AS show_times_per_day, RHS.price AS price FROM film AS LHS INNER JOIN schedule AS RHS ON (LHS.number_in_season = RHS.cinema_id))) ORDER BY directed_by;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.directed_by FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T2.directed_by ORDER BY SUM(T1.show_times_per_day) DESC, T2.directed_by NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/