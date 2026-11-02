-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1018, 'Kimberly Dudley', 1019, 1020, '959 Janet Cape Apt. 413
South Joshuastad, GA 49021');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1026, 'Maria Lynch', 1027, 1028, '76483 Cameron Trail
East Lydiamouth, MO 35594');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1021, 1022, 1023, 'Marine scientist', 'determine', 'religious', 'example');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1029, 1030, 1031, 'Brewing technologist', 'development', 'white', 'yes');
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1018, 1021, 'science', 1024, 1025.5);
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1026, 1029, 'our', 1032, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, maxprice AS max_t1_price_ FROM (SELECT LHS.film_id AS film_id, LHS.maxprice AS maxprice, RHS.rank_in_series AS rank_in_series, RHS.number_in_season AS number_in_season, RHS.title AS title, RHS.directed_by AS directed_by, RHS.original_air_date AS original_air_date, RHS.production_code AS production_code FROM (SELECT film_id, MAX(price) AS maxprice FROM schedule GROUP BY film_id) AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, max_t1_price_ NULLS LAST;

/*
Gold Result:
('Brewing technologist', None)
('Marine scientist', 1025.5)
*/

-- Prediction Query
SELECT T2.title, MAX(T1.price) FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T1.film_id;

/*
Prediction Result:
('Marine scientist', 1025.5)
('Brewing technologist', None)
*/