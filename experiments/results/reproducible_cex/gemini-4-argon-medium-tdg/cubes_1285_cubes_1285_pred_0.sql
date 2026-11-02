-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Title, secondary ordering by Film_ID (inserted out of order), and DISTINCT vs ALL with identical Title and Directed_by.
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (10, 1, 1, 'Zeta', 'Director A', '2020-01-01', 'P01');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (5, 2, 2, 'Alpha', 'Director B', '2020-01-02', 'P02');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (2, 3, 3, 'Alpha', 'Director C', '2020-01-03', 'P03');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (8, 4, 4, 'Beta', 'Director D', '2020-01-04', 'P04');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (3, 5, 5, 'Beta', 'Director D', '2020-01-05', 'P05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM film ORDER BY title, film.film_id NULLS LAST;

/*
Gold Result:
('Alpha', 'Director C')
('Alpha', 'Director B')
('Beta', 'Director D')
('Beta', 'Director D')
('Zeta', 'Director A')
*/

-- Prediction Query
SELECT title, directed_by FROM film;

/*
Prediction Result:
('Alpha', 'Director C')
('Beta', 'Director D')
('Alpha', 'Director B')
('Beta', 'Director D')
('Zeta', 'Director A')
*/