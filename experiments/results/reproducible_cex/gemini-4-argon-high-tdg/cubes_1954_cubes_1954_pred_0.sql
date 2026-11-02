-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (10, 'Spring Arts', 'Alice Green', 'Paris', 2006, 1500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (20, 'Summer Gala', 'Bob White', 'London', 2007, 3000);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (30, 'Autumn Expo', 'Carol Black', 'Berlin', 2007, 2500);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (40, 'Winter Show', 'David Gray', 'Rome', 2008, 1800);
INSERT INTO festival_detail (Festival_ID, Festival_Name, Chair_Name, Location, Year, Num_of_Audience) VALUES (50, 'Empty Fest', 'Eve Blue', 'Madrid', 2007, 500);
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (1, 'Sculpture', 'Alpha');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (2, 'Painting', 'Beta');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (3, 'Painting', 'Gamma');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (4, 'Architecture', 'Zeta');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (10, 'Photography', 'Delta');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (20, 'Literature', 'Epsilon');
INSERT INTO artwork (Artwork_ID, Type, Name) VALUES (30, 'Dance', 'Theta');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 20, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (1, 30, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (2, 20, 'Lost');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (3, 30, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (4, 30, 'Nominated');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (10, 10, 'Won');
INSERT INTO nomination (Artwork_ID, Festival_ID, Result) VALUES (20, 40, 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, LHS.festival_id AS festival_id, LHS.result AS RESULT, RHS.festival_name AS festival_name, RHS.chair_name AS chair_name, RHS.location AS LOCATION, RHS.year AS YEAR, RHS.num_of_audience AS num_of_audience FROM (SELECT LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.festival_id AS festival_id, RHS.result AS RESULT FROM artwork AS LHS INNER JOIN nomination AS RHS ON (LHS.artwork_id = RHS.artwork_id)) AS LHS INNER JOIN (SELECT * FROM festival_detail WHERE (YEAR = 2007)) AS RHS ON (LHS.festival_id = RHS.festival_id)) ORDER BY TYPE;

/*
Gold Result:
('Architecture',)
('Painting',)
('Sculpture',)
*/

-- Prediction Query
SELECT DISTINCT T2.Type FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID WHERE T3.Year = 2007;

/*
Prediction Result:
('Sculpture',)
('Painting',)
('Architecture',)
*/