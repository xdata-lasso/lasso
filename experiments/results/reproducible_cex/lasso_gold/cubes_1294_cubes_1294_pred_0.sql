-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1041, 'Troy Liu', 1042, 1043, '148 Eric Track
New Stephanie, NC 00575');
INSERT INTO "cinema" ("cinema_id", "name", "openning_year", "capacity", "location") VALUES (1055, 'Michelle Ross', 1056, 1057, '8713 Caleb Brooks Apt. 930
Lake Crystalbury, CA 04618');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1044, 1045, 1041, 'Tour manager', 'game', 'middle', 'after');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1051, 1052, 1041, 'Engineer, mining', 'woman', 'notice', 'someone');
INSERT INTO "film" ("film_id", "rank_in_series", "number_in_season", "title", "directed_by", "original_air_date", "production_code") VALUES (1058, 1059, 1055, 'Lawyer', 'avoid', 'my', 'economy');
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1041, 1044, 'brother', 1046, 1047.5);
INSERT INTO "schedule" ("cinema_id", "film_id", "date", "show_times_per_day", "price") VALUES (1055, 1058, 'family', 1060, 1061.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT directed_by FROM (SELECT film_id, rank_in_series, number_in_season, title, directed_by, original_air_date, production_code, film_id_other, date, show_times_per_day, price, number_in_season AS cinema_id FROM (SELECT LHS.film_id AS film_id, LHS.rank_in_series AS rank_in_series, LHS.number_in_season AS number_in_season, LHS.title AS title, LHS.directed_by AS directed_by, LHS.original_air_date AS original_air_date, LHS.production_code AS production_code, RHS.film_id AS film_id_other, RHS.date AS date, RHS.show_times_per_day AS show_times_per_day, RHS.price AS price FROM film AS LHS INNER JOIN schedule AS RHS ON (LHS.number_in_season = RHS.cinema_id))) ORDER BY directed_by;

/*
Gold Result:
('avoid',)
('game',)
('woman',)
*/

-- Prediction Query
SELECT T2.directed_by FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T2.directed_by ORDER BY SUM(T1.show_times_per_day) DESC, T2.directed_by NULLS LAST LIMIT 1;

/*
Prediction Result:
('avoid',)
*/