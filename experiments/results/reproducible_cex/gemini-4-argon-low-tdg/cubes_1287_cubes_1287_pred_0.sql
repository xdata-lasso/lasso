-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (20, 'Westside', 1995, 300, 'Miami');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (10, 'Eastside', 2015, 150, 'Miami');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (30, 'Southside', 2000, 450, 'Dallas');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM (SELECT * FROM (SELECT * FROM cinema ORDER BY LOCATION DESC, cinema.cinema_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Eastside', 'Miami')
*/

-- Prediction Query
SELECT name, LOCATION FROM cinema ORDER BY capacity DESC, cinema.cinema_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Southside', 'Dallas')
*/