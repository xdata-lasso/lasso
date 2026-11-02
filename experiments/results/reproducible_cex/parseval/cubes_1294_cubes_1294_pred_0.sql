-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1, 1, 1, 'lhs_19e3fa', 'lhs_300e3e', 'lhs_c44fc0', 'lhs_afcec5');

INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (2, 1, 1, 'lhs_19e3fa', 'lhs_300e3e', 'lhs_c44fc0', 'lhs_afcec5');

INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (3, 1, 1, 'lhs_941feb', 'lhs_9b1f6f', 'lhs_466c5c', 'lhs_4b70ca');

-- Inserting into table: cinema --
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (2, 'a2ypuzhsrwbb', 1072996612, 13244799, 'hvdltt');

-- Inserting into table: schedule --
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1, 1, 'e4', 1160656988, 268.82475);

INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (2, 1, 'rhs_0561d5', 1, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT directed_by FROM (SELECT film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code, film_id_other, date, show_times_per_day, price, number_in_season AS cinema_id FROM (SELECT LHS.film_id AS film_id, LHS.rank_in_series AS rank_in_series, LHS.number_in_season AS number_in_season, LHS.title AS title, LHS.directed_by AS directed_by, LHS.original_air_date AS original_air_date, LHS.production_code AS production_code, RHS.film_id AS film_id_other, RHS.date AS date, RHS.show_times_per_day AS show_times_per_day, RHS.price AS price FROM film AS LHS INNER JOIN schedule AS RHS ON (LHS.number_in_season = RHS.cinema_id))) ORDER BY directed_by;

/*
Gold Result:
('lhs_300e3e',)
('lhs_9b1f6f',)
*/

-- Prediction Query
SELECT T2.directed_by FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T2.directed_by ORDER BY SUM(T1.show_times_per_day) DESC, T2.directed_by NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_300e3e',)
*/