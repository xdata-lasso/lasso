-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (1, 'Venice', 'Dan', 'Italy', 2019, 1200);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (2, NULL, 'Eve', 'Spain', 2020, 800);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (3, 'Berlin', 'Frank', 'Germany', 2021, 2500);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (10, 'Film', 'Sunset');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (20, 'Painting', 'Aurora');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (30, 'Sculpture', NULL);
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 2, 'Lost');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 3, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (20, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (20, 3, 'Lost');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (30, 1, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (30, 2, 'Lost');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (30, 3, 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, festival_name FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id)) ORDER BY name, festival_name NULLS LAST;

/*
Gold Result:
(None, 'Berlin')
(None, 'Venice')
(None, None)
('Aurora', 'Berlin')
('Aurora', 'Venice')
('Sunset', 'Berlin')
('Sunset', 'Venice')
('Sunset', None)
*/

-- Prediction Query
SELECT T2.Name, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID;

/*
Prediction Result:
('Sunset', 'Venice')
('Sunset', None)
('Sunset', 'Berlin')
('Aurora', 'Venice')
('Aurora', 'Berlin')
(None, 'Venice')
(None, None)
(None, 'Berlin')
*/