-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Window function COUNT(*) OVER () vs GROUP BY / PARTITION BY festival_id.
-- Total nominations = 2 across two different festivals (1 nomination each).
-- Gold query returns both festivals (n = 2 >= 2).
-- Mutants grouping by festival_id (HAVING COUNT(*) >= 2) will return 0 rows.
-- Also tests ordering (Festival_ID 2 vs 10) and unnominated festivals/artworks.
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (10, 'Alpha Fest', 'Alice', 'NYC', 2020, 100);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'Zeta Fest', 'Bob', 'LA', 2021, 200);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (5, 'Unnominated Fest', 'Charlie', 'SF', 2022, 300);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (101, 'Painting', 'Sun');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (102, 'Sculpture', 'Moon');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (103, 'Video', 'Star');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (101, 10, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (102, 2, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT festival_id, festival_name FROM (SELECT festival_id, festival_name, chair_name, LOCATION, YEAR, num_of_audience, artwork_id, TYPE, name, RESULT, COUNT(*) OVER () AS n FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id))) WHERE (n >= 2) ORDER BY festival_id, festival_name NULLS LAST;

/*
Gold Result:
(2, 'Zeta Fest')
(10, 'Alpha Fest')
*/

-- Prediction Query
SELECT T1.Festival_ID, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID GROUP BY T1.Festival_ID HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/