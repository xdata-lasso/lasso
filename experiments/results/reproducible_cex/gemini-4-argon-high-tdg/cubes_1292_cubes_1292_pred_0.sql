-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 10, 1, 'Inception', 'Christopher Nolan', '2010-07-16', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 20, 2, 'Avatar', 'James Cameron', '2009-12-18', 'P102');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (3, 30, 3, 'Unscheduled Film', 'Steven Spielberg', '2015-06-01', 'P103');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Metro Cinema', 1995, 150, 'New York');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Grand Theater', 2005, 300, 'Los Angeles');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Plaza Multiplex', 2012, 250, 'Chicago');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Unused Cinema', 2018, 100, 'Boston');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2023-05-01', 3, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (3, 1, '2023-05-02', 5, 18.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 2, '2023-05-01', 4, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (3, 2, '2023-05-03', 2, 9.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, maxprice AS max_t1_price_ FROM (SELECT LHS.film_id AS film_id, LHS.maxprice AS maxprice, RHS.rank_in_series AS rank_in_series, RHS.number_in_season AS number_in_season, RHS.title AS title, RHS.directed_by AS directed_by, RHS.original_air_date AS original_air_date, RHS.production_code AS production_code FROM (SELECT film_id, MAX(price) AS maxprice FROM schedule GROUP BY film_id) AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, max_t1_price_ NULLS LAST;

/*
Gold Result:
('Avatar', 15.0)
('Inception', 18.0)
*/

-- Prediction Query
SELECT T2.title, MAX(T1.price) FROM schedule AS T1 JOIN film AS T2 ON T1.film_id = T2.film_id GROUP BY T1.film_id;

/*
Prediction Result:
('Inception', 18.0)
('Avatar', 15.0)
*/