-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic aggregation (MAX vs MIN/SUM/AVG/COUNT), JOIN filtering (film with no schedule), and ORDER BY title
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Metro', 1995, 200, 'Downtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Plaza', 2001, 300, 'Uptown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Grand', 2010, 400, 'Suburb');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 10, 1, 'Zeta', 'Dir A', '2020-01-01', 'P1');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 20, 2, 'Alpha', 'Dir B', '2020-01-02', 'P2');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (3, 30, 3, 'Unscheduled Film', 'Dir C', '2020-01-03', 'P3');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2023-05-01', 3, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 1, '2023-05-02', 4, 25.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (3, 1, '2023-05-03', 2, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 2, '2023-05-01', 5, 10.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 2, '2023-05-02', 5, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, maxprice AS max_t1_price_ FROM (SELECT LHS.film_id AS film_id, LHS.maxprice AS maxprice, RHS.rank_in_series AS rank_in_series, RHS.number_in_season AS number_in_season, RHS.title AS title, RHS.directed_by AS directed_by, RHS.original_air_date AS original_air_date, RHS.production_code AS production_code FROM (SELECT film_id, MAX(price) AS maxprice FROM schedule GROUP BY film_id) AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, max_t1_price_ NULLS LAST;

/*
Gold Result:
('Alpha', 20.0)
('Zeta', 25.0)
*/

-- Prediction Query
SELECT T2.title, MAX(T1.price) FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T1.film_id;

/*
Prediction Result:
('Zeta', 25.0)
('Alpha', 20.0)
*/