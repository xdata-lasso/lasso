-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Cinema_ID, exact duplicates (SELECT vs SELECT DISTINCT), and column disambiguation (Openning_year vs Capacity vs Cinema_ID).
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Metro', 2010, 500, 'North');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Apex', 2005, 300, 'East');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Apex', 1998, 400, 'West');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Apex', 2005, 250, 'South');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('Apex', 2005)
('Apex', 1998)
('Apex', 2005)
('Metro', 2010)
*/

-- Prediction Query
SELECT name, openning_year FROM cinema ORDER BY openning_year DESC, cinema.cinema_id NULLS LAST;

/*
Prediction Result:
('Metro', 2010)
('Apex', 2005)
('Apex', 2005)
('Apex', 1998)
*/