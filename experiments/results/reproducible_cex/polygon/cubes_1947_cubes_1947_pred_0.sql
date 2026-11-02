-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (22, NULL, NULL, '29', 30, 31);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (39, '40', '41');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (35, '36', '37');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (35, 22, '34');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (39, 22, '38');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT festival_id, festival_name FROM (SELECT festival_id, festival_name, chair_name, LOCATION, YEAR, num_of_audience, artwork_id, TYPE, name, RESULT, COUNT(*) OVER () AS n FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id))) WHERE (n >= 2) ORDER BY festival_id, festival_name NULLS LAST;

/*
Gold Result:
(22, None)
*/

-- Prediction Query
SELECT T1.Festival_ID, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID GROUP BY T1.Festival_ID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(22, None)
*/