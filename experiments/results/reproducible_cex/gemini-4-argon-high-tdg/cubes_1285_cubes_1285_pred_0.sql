-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 1, 1, 'Zootopia', 'Byron Howard', '2016-03-04', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 10, 10, 'Avatar', 'Zack Snyder', '2022-12-16', 'P999');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (10, 2, 2, 'Avatar', 'Alan Smithee', '2009-12-18', 'P001');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (15, 3, 3, 'Inception', 'Christopher Nolan', '2010-07-16', 'P200');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (20, 4, 4, 'Inception', 'Christopher Nolan', '2010-07-16', 'P201');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Grand Rex', 1932, 2700, 'Paris');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Odeon', 1950, 800, 'London');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2023-05-01', 4, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 1, '2023-05-02', 3, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 2, '2023-05-03', 2, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, directed_by FROM film ORDER BY title, film.film_id NULLS LAST;

/*
Gold Result:
('Avatar', 'Zack Snyder')
('Avatar', 'Alan Smithee')
('Inception', 'Christopher Nolan')
('Inception', 'Christopher Nolan')
('Zootopia', 'Byron Howard')
*/

-- Prediction Query
SELECT title, directed_by FROM film;

/*
Prediction Result:
('Zootopia', 'Byron Howard')
('Avatar', 'Zack Snyder')
('Avatar', 'Alan Smithee')
('Inception', 'Christopher Nolan')
('Inception', 'Christopher Nolan')
*/