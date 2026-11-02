-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'F1', 'C1', 'L1', 2007, 100);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, 'F2', 'C2', 'L2', 2007, 200);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'F3', 'C3', 'L3', 2007, 300);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (10, 'Zebra_Art', 'Alpha_Name');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (20, 'Alpha_Art', 'Zebra_Name');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (30, 'Unnominated_Art', 'Mid_Name');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 2, 'Lost');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (20, 1, 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, LHS.festival_id AS festival_id, LHS.result AS RESULT, RHS.festival_name AS festival_name, RHS.chair_name AS chair_name, RHS.location AS LOCATION, RHS.year AS YEAR, RHS.num_of_audience AS num_of_audience FROM (SELECT LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.festival_id AS festival_id, RHS.result AS RESULT FROM artwork AS LHS INNER JOIN nomination AS RHS ON (LHS.artwork_id = RHS.artwork_id)) AS LHS INNER JOIN (SELECT * FROM festival_detail WHERE (YEAR = 2007)) AS RHS ON (LHS.festival_id = RHS.festival_id)) ORDER BY TYPE;

/*
Gold Result:
('Alpha_Art',)
('Zebra_Art',)
*/

-- Prediction Query
SELECT DISTINCT T2.Type FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID WHERE T3.Year = 2007;

/*
Prediction Result:
('Zebra_Art',)
('Alpha_Art',)
*/