-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. NULL handling in SUM and ORDER BY ... NULLS LAST (Cinema 1 has only NULL show_times_per_day, resulting in a NULL sum, which must sort after Cinema 2's sum of 10).
-- 2. Partial NULL in SUM (Cinema 3 has one NULL and one non-NULL show_times_per_day; SUM should ignore NULL and return 7).
-- 3. NULL handling in Cinema Name (Cinema 4 has NULL name).
-- 4. SELECT DISTINCT vs SELECT ALL (Cinemas 5 and 6 have identical name 'Twin' and identical sum 6; since there is no DISTINCT in the outer query, both rows must be preserved).
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (1, 1, 1, 'Film A', 'Dir A', '2020-01-01', 'P01');
INSERT INTO "film" ("Film_ID", "Rank_in_series", "Number_in_season", "Title", "Directed_by", "Original_air_date", "Production_code") VALUES (2, 2, 2, 'Film B', 'Dir B', '2020-01-02', 'P02');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (1, 'Odeon', 1995, 300, 'Loc X');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (2, 'Odeon', 1998, 300, 'Loc Y');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (3, 'Cineworld', 2001, 400, 'Loc Z');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (4, NULL, 2005, 500, 'Loc W');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (5, 'Twin', 2010, 200, 'Loc V1');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (6, 'Twin', 2012, 250, 'Loc V2');
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (1, 1, '2022-05-01', NULL, 8.5);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (2, 1, '2022-05-01', 10, 9.5);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (3, 1, '2022-05-01', 7, 11.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (3, 2, '2022-05-02', NULL, 11.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (4, 1, '2022-05-01', 12, 10.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (5, 1, '2022-05-01', 6, 10.0);
INSERT INTO "schedule" ("Cinema_ID", "Film_ID", "Date", "Show_times_per_day", "Price") VALUES (6, 2, '2022-05-02', 6, 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sumshow_times_per_day AS sum_t1_show_times_per_day_ FROM (SELECT LHS.cinema_id AS cinema_id, LHS.sumshow_times_per_day AS sumshow_times_per_day, RHS.name AS name, RHS.openning_year AS openning_year, RHS.capacity AS capacity, RHS.location AS LOCATION FROM (SELECT cinema_id, SUM(show_times_per_day) AS sumshow_times_per_day FROM schedule GROUP BY cinema_id) AS LHS INNER JOIN cinema AS RHS ON (LHS.cinema_id = RHS.cinema_id)) ORDER BY name, sum_t1_show_times_per_day_ NULLS LAST;

/*
Gold Result:
(None, 12)
('Cineworld', 7)
('Odeon', 10)
('Odeon', None)
('Twin', 6)
('Twin', 6)
*/

-- Prediction Query
SELECT T2.name, SUM(T1.show_times_per_day) FROM schedule AS T1 JOIN cinema AS T2 ON T1.cinema_id = T2.cinema_id GROUP BY T1.cinema_id;

/*
Prediction Result:
('Odeon', None)
('Odeon', 10)
('Cineworld', 7)
(None, 12)
('Twin', 6)
('Twin', 6)
*/