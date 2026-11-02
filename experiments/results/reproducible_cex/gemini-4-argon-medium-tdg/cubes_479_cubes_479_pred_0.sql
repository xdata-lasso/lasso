-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'Loc1', 'Stad1', 10000, 12000, 8000, 9000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'Loc2', 'Stad2', 20000, 22000, 18000, 19000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (3, 'Loc3', 'Stad3', 30000, 32000, 28000, 29000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (10, 'Loc10', 'Stad10', 40000, 42000, 38000, 39000);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (1, '10', 'C1', 'T1', '2020');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (2, '1', 'C2', 'T2', '2018');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (3, '1', 'C3', 'T3', '2019');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (4, '2', 'C4', 'T4', '2021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT YEAR FROM (SELECT LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, RHS.concert_id AS concert_id_other, RHS.concert_name AS concert_name_other, RHS.theme AS theme_other, RHS.year AS year_other, RHS.n AS n FROM concert AS LHS INNER JOIN (SELECT concert_id, concert_name, theme, stadium_id, YEAR, COUNT(*) OVER () AS n FROM concert) AS RHS ON (LHS.concert_id = RHS.stadium_id)) ORDER BY YEAR;

/*
Gold Result:
('2018',)
('2020',)
*/

-- Prediction Query
SELECT YEAR FROM concert GROUP BY YEAR ORDER BY COUNT(*) DESC, YEAR NULLS LAST LIMIT 1;

/*
Prediction Result:
('2018',)
*/