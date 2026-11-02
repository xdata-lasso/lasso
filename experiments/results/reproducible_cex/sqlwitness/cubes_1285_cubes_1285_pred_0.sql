-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code) VALUES (0, NULL, NULL, NULL, NULL, 'default1', 'default1'), (1, 0, 1, NULL, NULL, 'default1', 'default2'), (2, 0, 0, 'default2', NULL, 'default1', 'default1'), (3, 0, NULL, 'default1', NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM film ORDER BY title, film.film_id NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT title, directed_by FROM film;

/*
Prediction Result:
(None, None)
(None, None)
('default2', None)
('default1', None)
*/