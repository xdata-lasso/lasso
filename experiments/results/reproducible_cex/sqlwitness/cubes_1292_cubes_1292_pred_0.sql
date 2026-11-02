-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (cinema_id, name, openning_year, capacity, location) VALUES (0, NULL, 1, 0, 'default2'), (1, 'default1', NULL, NULL, 'default1'), (2, 'default2', NULL, NULL, NULL), (3, NULL, 0, NULL, NULL), (4, 'default2', NULL, 1, NULL), (5, 'default1', 1, 0, 'default1'), (6, 'default1', 0, NULL, 'default2');
INSERT INTO film (film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code) VALUES (0, 1, NULL, 'default2', 'default2', 'default1', NULL), (1, NULL, NULL, 'default1', 'default1', 'default2', 'default1'), (2, 1, 0, NULL, NULL, 'default2', 'default1'), (3, NULL, 1, 'default1', 'default2', 'default1', NULL), (4, 1, NULL, 'default2', 'default2', NULL, NULL), (5, 0, 0, NULL, 'default1', 'default2', 'default2'), (6, 0, 1, NULL, NULL, 'default1', 'default1');
INSERT INTO schedule (cinema_id, film_id, date, show_times_per_day, price) VALUES (3, 5, 'default1', 1, 1.0), (5, 2, NULL, 1, 0.0), (1, 3, 'default2', NULL, NULL), (0, 3, 'default2', NULL, 1.0), (1, 1, 'default2', NULL, 1.0), (3, 1, 'default2', 1, 1.0), (2, 2, 'default1', 0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, maxprice AS max_t1_price_ FROM (SELECT LHS.film_id AS film_id, LHS.maxprice AS maxprice, RHS.rank_in_series AS rank_in_series, RHS.number_in_season AS number_in_season, RHS.title AS title, RHS.directed_by AS directed_by, RHS.original_air_date AS original_air_date, RHS.production_code AS production_code FROM (SELECT film_id, MAX(price) AS maxprice FROM schedule GROUP BY film_id) AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, max_t1_price_ NULLS LAST;

/*
Gold Result:
(None, 0.0)
(None, 1.0)
('default1', 1.0)
('default1', 1.0)
*/

-- Prediction Query
SELECT T2.title, MAX(T1.price) FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T1.film_id;

/*
Prediction Result:
('default1', 1.0)
(None, 0.0)
('default1', 1.0)
(None, 1.0)
*/