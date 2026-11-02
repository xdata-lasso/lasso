-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (1, 'Cannes', 'John Doe', 'France', 2020, 5000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (2, 'Sundance', 'Jane Smith', 'USA', 2021, 3000);
INSERT INTO "festival_detail" ("Festival_ID", "Festival_Name", "Chair_Name", "Location", "Year", "Num_of_Audience") VALUES (3, 'Unnominated Fest', 'Bob Brown', 'UK', 2022, 1000);
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (1, 'Film', 'Zebra');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (2, 'Painting', 'Alpha');
INSERT INTO "artwork" ("Artwork_ID", "Type", "Name") VALUES (3, 'Sculpture', 'Beta');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (1, 1, 'Won');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (1, 2, 'Nominated');
INSERT INTO "nomination" ("Artwork_ID", "Festival_ID", "Result") VALUES (2, 1, 'Lost');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zebra',)
('Zebra',)
*/

-- Prediction Query
SELECT T2.Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID ORDER BY T3.Year, T1.artwork_id NULLS LAST, T1.festival_id NULLS LAST, T2.artwork_id NULLS LAST, T3.festival_id NULLS LAST;

/*
Prediction Result:
('Zebra',)
('Alpha',)
('Zebra',)
*/