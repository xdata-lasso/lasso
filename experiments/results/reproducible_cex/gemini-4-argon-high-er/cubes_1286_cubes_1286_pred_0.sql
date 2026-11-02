-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (1, 'B', 2000, 100, 'Loc1');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (2, 'A', 2001, 200, 'Loc2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year, capacity FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('A', 2001, 200)
('B', 2000, 100)
*/

-- Prediction Query
SELECT name, openning_year, capacity FROM cinema;

/*
Prediction Result:
('B', 2000, 100)
('A', 2001, 200)
*/