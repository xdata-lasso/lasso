-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("Film_ID", "Title", "Directed_by") VALUES (1, 'Z', 'Director 1');
INSERT INTO "film" ("Film_ID", "Title", "Directed_by") VALUES (2, 'A', 'Director 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM film ORDER BY title, film.film_id NULLS LAST;

/*
Gold Result:
('A', 'Director 2')
('Z', 'Director 1')
*/

-- Prediction Query
SELECT title, directed_by FROM film;

/*
Prediction Result:
('Z', 'Director 1')
('A', 'Director 2')
*/