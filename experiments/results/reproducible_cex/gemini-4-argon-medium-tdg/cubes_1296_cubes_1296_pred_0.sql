-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (30, 'Zeta', 1995, 100, 'North');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (10, 'Beta', 2010, 500, 'South');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (20, 'Alpha', 2005, 300, 'East');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 1, 1, 'Movie A', 'Dir A', '2020-01-01', 'P1');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (10, 1, '2023-05-01', 3, 12.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('Alpha', 2005)
('Beta', 2010)
('Zeta', 1995)
*/

-- Prediction Query
SELECT name, openning_year FROM cinema ORDER BY openning_year DESC, cinema.cinema_id NULLS LAST;

/*
Prediction Result:
('Beta', 2010)
('Alpha', 2005)
('Zeta', 1995)
*/