-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN behavior vs OUTER JOINs (unmatched festival and artwork rows)
-- Tests primary and secondary ORDER BY (ASC vs DESC, column order)
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Zeta Fest', 'Alice', 'NY', 2020, 100);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Alpha Fest', 'Bob', 'LA', 2021, 200);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'Unmatched Fest', 'Charlie', 'SF', 2022, 300);
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (10, 'Painting', 'Sunflowers');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (20, 'Sculpture', 'Art A');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (30, 'Photograph', 'Unmatched Art');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (10, 1, 'Won');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (20, 1, 'Nominated');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (20, 2, 'Lost');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, festival_name FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id)) ORDER BY name, festival_name NULLS LAST;

/*
Gold Result:
('Art A', 'Alpha Fest')
('Art A', 'Zeta Fest')
('Sunflowers', 'Zeta Fest')
*/

-- Prediction Query
SELECT T2.Name, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID;

/*
Prediction Result:
('Sunflowers', 'Zeta Fest')
('Art A', 'Zeta Fest')
('Art A', 'Alpha Fest')
*/