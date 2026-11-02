-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1022, 'account', 'Mark Perez');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1025, NULL, NULL);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1023, 'Shannon Jones', 'Michael Lewis', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 2007, 1024);
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (1022, 1023, 'customer');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (1025, 1023, 'customer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, LHS.festival_id AS festival_id, LHS.result AS RESULT, RHS.festival_name AS festival_name, RHS.chair_name AS chair_name, RHS.location AS LOCATION, RHS.year AS YEAR, RHS.num_of_audience AS num_of_audience FROM (SELECT LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.festival_id AS festival_id, RHS.result AS RESULT FROM artwork AS LHS INNER JOIN nomination AS RHS ON (LHS.artwork_id = RHS.artwork_id)) AS LHS INNER JOIN (SELECT * FROM festival_detail WHERE (YEAR = 2007)) AS RHS ON (LHS.festival_id = RHS.festival_id)) ORDER BY TYPE;

/*
Gold Result:
(None,)
('account',)
*/

-- Prediction Query
SELECT DISTINCT T2.Type FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID WHERE T3.Year = 2007;

/*
Prediction Result:
('account',)
(None,)
*/