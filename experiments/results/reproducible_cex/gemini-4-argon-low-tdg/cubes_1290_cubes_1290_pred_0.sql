-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 10, 5, 'The Beginning', 'Zack Snyder', '2020-05-01', 'P103');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 1, 2, 'Middle Ground', 'Christopher Nolan', '2019-01-15', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (3, 5, 1, 'Endgame', 'Christopher Nolan', '2021-12-10', 'P102');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (4, 2, 8, 'New Dawn', 'Alfonso Cuaron', '2018-03-20', 'P100');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Grand Cinema', 2010, 300, 'Downtown');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2022-01-01', 3, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 2, '2022-01-02', 4, 15.0);
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