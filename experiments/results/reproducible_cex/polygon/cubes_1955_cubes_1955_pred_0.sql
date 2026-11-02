-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (24, '25', NULL, '27', NULL, NULL);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (19, '30', NULL, '32', NULL, NULL);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (41, NULL, NULL);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (35, '36', NULL);
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (41, 19, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, festival_name FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id)) ORDER BY name, festival_name NULLS LAST;

/*
Gold Result:
(None, '30')
*/

-- Prediction Query
SELECT T2.Name, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID;

/*
Prediction Result:
(None, '30')
*/