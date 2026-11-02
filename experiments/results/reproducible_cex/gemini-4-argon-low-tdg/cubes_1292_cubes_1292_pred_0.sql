-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (1, 10, 1, 'Alpha', 'Dir A', '2020-01-01', 'P101');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (2, 20, 2, 'Alpha', 'Dir B', '2020-01-02', 'P102');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (3, 30, 3, 'Beta', 'Dir C', '2020-01-03', 'P103');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (4, 40, 4, 'Gamma', 'Dir D', '2020-01-04', 'P104');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (10, 'Cin 1', 2000, 100, 'Loc A');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (20, 'Cin 2', 2005, 150, 'Loc B');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (30, 'Cin 3', 2010, 200, 'Loc C');
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (10, 1, '2023-05-01', 3, 12.5);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (20, 1, '2023-05-02', 4, 25.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (30, 1, '2023-05-03', 2, 15.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (10, 2, '2023-05-01', 5, 10.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (20, 2, '2023-05-02', 1, 18.5);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (10, 3, '2023-05-01', 2, 8.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, maxprice AS max_t1_price_ FROM (SELECT LHS.film_id AS film_id, LHS.maxprice AS maxprice, RHS.rank_in_series AS rank_in_series, RHS.number_in_season AS number_in_season, RHS.title AS title, RHS.directed_by AS directed_by, RHS.original_air_date AS original_air_date, RHS.production_code AS production_code FROM (SELECT film_id, MAX(price) AS maxprice FROM schedule GROUP BY film_id) AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, max_t1_price_ NULLS LAST;

/*
Gold Result:
('Alpha', 18.5)
('Alpha', 25.0)
('Beta', 8.0)
*/

-- Prediction Query
SELECT T2.title, MAX(T1.price) FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T1.film_id;

/*
Prediction Result:
('Alpha', 25.0)
('Alpha', 18.5)
('Beta', 8.0)
*/