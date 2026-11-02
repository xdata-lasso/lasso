-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 1, 1, 'Pilot', 'John Doe', '2020-01-01', 'P101');
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (2, 2, 2, 'Finale', 'Jane Roe', '2020-01-08', 'P102');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Alpha', 2000, 200, 'Seattle');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Gamma', 2010, 450, 'Austin');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Delta', 2015, 500, 'Austin');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Beta', 1995, 799, 'Denver');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (5, 'Epsilon', 2005, 400, 'Boston');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (6, 'Zeta', 2008, 800, 'Boston');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (7, 'Eta', 2012, 300, 'Chicago');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (8, 'Theta', 2018, 950, 'Chicago');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (9, 'Iota', 2020, 801, 'Miami');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2023-05-01', 4, 12.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 1, '2023-05-01', 3, 10.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (5, 2, '2023-05-02', 5, 15.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (7, 1, '2023-05-03', 2, 11.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (8, 2, '2023-05-03', 6, 18.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (9, 1, '2023-05-04', 4, 14.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT * FROM cinema AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM cinema WHERE (capacity >= 800)) AS RHS WHERE (LHS.location = RHS.location))) ORDER BY LOCATION;

/*
Gold Result:
('Austin',)
('Denver',)
('Seattle',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema EXCEPT SELECT LOCATION FROM cinema WHERE capacity > 800;

/*
Prediction Result:
('Austin',)
('Boston',)
('Denver',)
('Seattle',)
*/