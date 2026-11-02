-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests core relational division / anti-join logic, DISTINCT requirement, boundary values (799, 800, 801), and unreferenced cinemas (no schedule).
INSERT INTO film (Film_ID, Rank_in_series, Number_in_season, Title, Directed_by, Original_air_date, Production_code) VALUES (1, 1, 1, 'Film One', 'Dir A', '2020-01-01', 'P01');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'C1', 2000, 500, 'Loc_Mixed');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'C2', 2005, 850, 'Loc_Mixed');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'C3', 2010, 800, 'Loc_Exact800');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'C4', 2012, 799, 'Loc_Boundary799');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (5, 'C5', 2015, 300, 'Loc_MultiLow');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (6, 'C6', 2018, 400, 'Loc_MultiLow');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (7, 'C7', 2020, 801, 'Loc_HighOnly');
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (1, 1, '2022-05-01', 3, 10.5);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (2, 1, '2022-05-01', 4, 12.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (3, 1, '2022-05-01', 2, 11.0);
INSERT INTO schedule (Cinema_ID, Film_ID, Date, Show_times_per_day, Price) VALUES (5, 1, '2022-05-01', 5, 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT * FROM cinema AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM cinema WHERE (capacity >= 800)) AS RHS WHERE (LHS.location = RHS.location))) ORDER BY LOCATION;

/*
Gold Result:
('Loc_Boundary799',)
('Loc_MultiLow',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema EXCEPT SELECT LOCATION FROM cinema WHERE capacity > 800;

/*
Prediction Result:
('Loc_Boundary799',)
('Loc_Exact800',)
('Loc_MultiLow',)
*/