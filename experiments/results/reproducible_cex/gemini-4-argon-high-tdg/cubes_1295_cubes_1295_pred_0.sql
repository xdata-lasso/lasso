-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (10, 1, 1, 'Pilot', 'John Doe', '2020-01-01', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (20, 2, 2, 'The Sequel', 'Jane Roe', '2020-01-08', 'P102');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (30, 3, 3, 'Unscheduled Film', 'Jim Beam', '2020-01-15', 'P103');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Grand', 2000, 300, 'Downtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Apex', 2010, 150, 'Uptown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Apex', 2015, 200, 'Midtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Plaza', 1995, 100, 'Suburb');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 10, '2023-05-01', 4, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 20, '2023-05-02', 4, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 10, '2023-05-01', 10, 10.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (3, 10, '2023-05-01', 2, 8.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (3, 20, '2023-05-02', 3, 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sumshow_times_per_day AS sum_t1_show_times_per_day_ FROM (SELECT LHS.cinema_id AS cinema_id, LHS.sumshow_times_per_day AS sumshow_times_per_day, RHS.name AS name, RHS.openning_year AS openning_year, RHS.capacity AS capacity, RHS.location AS LOCATION FROM (SELECT cinema_id, SUM(show_times_per_day) AS sumshow_times_per_day FROM schedule GROUP BY cinema_id) AS LHS INNER JOIN cinema AS RHS ON (LHS.cinema_id = RHS.cinema_id)) ORDER BY name, sum_t1_show_times_per_day_ NULLS LAST;

/*
Gold Result:
('Apex', 5)
('Apex', 10)
('Grand', 8)
*/

-- Prediction Query
SELECT T2.name, SUM(T1.show_times_per_day) FROM schedule AS T1 JOIN cinema AS T2 ON T1.cinema_id = T2.cinema_id GROUP BY T1.cinema_id;

/*
Prediction Result:
('Grand', 8)
('Apex', 10)
('Apex', 5)
*/