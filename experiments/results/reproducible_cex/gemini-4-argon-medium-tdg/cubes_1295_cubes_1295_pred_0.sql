-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (101, 1, 1, 'Alpha', 'Dir A', '2020-01-01', 'P101');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (102, 2, 2, 'Beta', 'Dir B', '2020-01-02', 'P102');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (103, 3, 3, 'Gamma', 'Dir C', '2020-01-03', 'P103');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (1, 'Metro', 2000, 300, 'Loc A');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (2, 'Apex', 2005, 400, 'Loc B');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (3, 'Ghost Cinema', 2010, 500, 'Loc C');
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (1, 101, '2022-05-01', 4, 12.5);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (1, 102, '2022-05-02', 4, 15.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (2, 101, '2022-05-01', 3, 10.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (2, 103, '2022-05-03', 7, 11.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sumshow_times_per_day AS sum_t1_show_times_per_day_ FROM (SELECT LHS.cinema_id AS cinema_id, LHS.sumshow_times_per_day AS sumshow_times_per_day, RHS.name AS name, RHS.openning_year AS openning_year, RHS.capacity AS capacity, RHS.location AS LOCATION FROM (SELECT cinema_id, SUM(show_times_per_day) AS sumshow_times_per_day FROM schedule GROUP BY cinema_id) AS LHS INNER JOIN cinema AS RHS ON (LHS.cinema_id = RHS.cinema_id)) ORDER BY name, sum_t1_show_times_per_day_ NULLS LAST;

/*
Gold Result:
('Apex', 10)
('Metro', 8)
*/

-- Prediction Query
SELECT T2.name, SUM(T1.show_times_per_day) FROM schedule AS T1 JOIN cinema AS T2 ON T1.cinema_id = T2.cinema_id GROUP BY T1.cinema_id;

/*
Prediction Result:
('Metro', 8)
('Apex', 10)
*/