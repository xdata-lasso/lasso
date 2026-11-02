-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 1, 1, 'Pilot', 'John Doe', '2020-01-01', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 2, 2, 'Finale', 'Jane Roe', '2020-01-08', 'P102');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Zeta Theater', 1995, 300, 'Downtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Metro', 2015, 500, 'Uptown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Metro', 1985, 200, 'Midtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Alpha Cinema', 2005, 400, 'Suburb');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (5, 'Alpha Cinema', 2005, 150, 'Eastside');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2023-05-01', 3, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 2, '2023-05-02', 2, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 1, '2023-05-01', 4, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('Alpha Cinema', 2005)
('Alpha Cinema', 2005)
('Metro', 2015)
('Metro', 1985)
('Zeta Theater', 1995)
*/

-- Prediction Query
SELECT name, openning_year FROM cinema ORDER BY openning_year DESC, cinema.cinema_id NULLS LAST;

/*
Prediction Result:
('Metro', 2015)
('Alpha Cinema', 2005)
('Alpha Cinema', 2005)
('Zeta Theater', 1995)
('Metro', 1985)
*/