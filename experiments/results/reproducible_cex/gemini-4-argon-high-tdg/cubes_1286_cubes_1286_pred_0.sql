-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 1, 1, 'Pilot', 'John Doe', '2020-01-01', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 2, 2, 'Finale', 'Jane Roe', '2020-01-08', 'P102');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (10, 'Apex', 2005, 200, 'Midtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (20, 'Apex', 2010, 100, 'Zootown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (30, 'Apex', 2000, 300, 'Arttown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (5, 'Zenith', 1995, 500, 'Downtown');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (15, 'Beacon', 2015, 150, 'Uptown');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (5, 1, '2023-05-01', 3, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (5, 2, '2023-05-02', 4, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (10, 1, '2023-05-03', 2, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, openning_year, capacity FROM cinema ORDER BY name, cinema.cinema_id NULLS LAST;

/*
Gold Result:
('Apex', 2005, 200)
('Apex', 2010, 100)
('Apex', 2000, 300)
('Beacon', 2015, 150)
('Zenith', 1995, 500)
*/

-- Prediction Query
SELECT name, openning_year, capacity FROM cinema;

/*
Prediction Result:
('Zenith', 1995, 500)
('Apex', 2005, 200)
('Beacon', 2015, 150)
('Apex', 2010, 100)
('Apex', 2000, 300)
*/