-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Duplicate elimination (DISTINCT), reverse insertion order vs alphabetical order (ORDER BY), and films not present in schedule (catches unnecessary INNER JOIN with schedule/cinema).
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 10, 1, 'Alpha', 'Zack Snyder', '2020-01-01', 'P03');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 20, 2, 'Beta', 'Christopher Nolan', '2020-01-02', 'P02');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (3, 30, 3, 'Gamma', 'Zack Snyder', '2020-01-03', 'P01');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (4, 40, 4, 'Delta', 'Alfonso Cuaron', '2020-01-04', 'P04');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Grand Cinema', 2010, 500, 'Downtown');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2020-05-01', 4, 12.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT directed_by FROM film ORDER BY directed_by;

/*
Gold Result:
('Alfonso Cuaron',)
('Christopher Nolan',)
('Zack Snyder',)
*/

-- Prediction Query
SELECT DISTINCT directed_by FROM film;

/*
Prediction Result:
('Zack Snyder',)
('Christopher Nolan',)
('Alfonso Cuaron',)
*/