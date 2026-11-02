-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (30, NULL, 2000, 100, 'Unknown');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (10, NULL, 2020, 400, NULL);
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (25, 'Starlight', NULL, 200, 'Center');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (15, 'Metro', 1980, NULL, 'Suburb');
INSERT INTO "cinema" ("Cinema_ID", "Name", "Openning_year", "Capacity", "Location") VALUES (5, 'Beacon', 2010, 0, '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year, capacity FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
(None, 2020, 400)
(None, 2000, 100)
('Beacon', 2010, 0)
('Metro', 1980, None)
('Starlight', None, 200)
*/

-- Prediction Query
SELECT name, openning_year, capacity FROM cinema;

/*
Prediction Result:
('Beacon', 2010, 0)
(None, 2020, 400)
('Metro', 1980, None)
('Starlight', None, 200)
(None, 2000, 100)
*/