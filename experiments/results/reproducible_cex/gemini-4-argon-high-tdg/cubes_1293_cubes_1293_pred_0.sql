-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Rank_in_series" INTEGER, "Number_in_season" INTEGER, "Title" TEXT, "Directed_by" TEXT, "Original_air_date" TEXT, "Production_code" TEXT);

CREATE TABLE "cinema" ("Cinema_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Openning_year" INTEGER, "Capacity" INTEGER, "Location" TEXT);

CREATE TABLE "schedule" ("Cinema_ID" INTEGER, "Film_ID" INTEGER, "Date" TEXT, "Show_times_per_day" INTEGER, "Price" REAL, PRIMARY KEY ("Cinema_ID", "Film_ID"), FOREIGN KEY ("Cinema_ID") REFERENCES "cinema" ("Cinema_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (1, 'Zeta One', 1995, 200, 'Zeta');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (2, 'Zeta Two', 1995, 250, 'Zeta');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (3, 'Solo 95', 1995, 180, 'SingleLoc');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (4, 'Split A', 2000, 150, 'SplitYears');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (5, 'Split B', 2001, 150, 'SplitYears');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (6, 'Alpha One', 2020, 400, 'Alpha');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (7, 'Alpha Two', 2020, 450, 'Alpha');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (8, 'Alpha Three', 2020, 500, 'Alpha');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (9, 'Beta 05 A', 2005, 120, 'Beta');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (10, 'Beta 05 B', 2005, 130, 'Beta');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (11, 'Beta 10 A', 2010, 220, 'Beta');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (12, 'Beta 10 B', 2010, 240, 'Beta');
INSERT INTO cinema (Cinema_ID, Name, Openning_year, Capacity, Location) VALUES (13, 'Beta 15 Solo', 2015, 310, 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LOCATION, openning_year, COUNT(*) AS n FROM cinema GROUP BY LOCATION, openning_year) WHERE (n = 300 OR n <> 1) ORDER BY LOCATION;

/*
Gold Result:
('Alpha',)
('Beta',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT LOCATION FROM cinema WHERE capacity > 300 GROUP BY LOCATION HAVING COUNT(*) > 1;

/*
Prediction Result:
('Alpha',)
*/