-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (30, 'Zeta', 1995, 300, 'North');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (20, 'Alpha', 2010, 150, 'East');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (10, 'Alpha', 2000, 500, 'West');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (40, 'Beta', 2005, 250, 'South');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year, capacity FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('Alpha', 2000, 500)
('Alpha', 2010, 150)
('Beta', 2005, 250)
('Zeta', 1995, 300)
*/

-- Prediction Query
SELECT name, openning_year, capacity FROM cinema;

/*
Prediction Result:
('Alpha', 2000, 500)
('Alpha', 2010, 150)
('Zeta', 1995, 300)
('Beta', 2005, 250)
*/