-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (11, '19', '19', '19', 19, 19);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (10, '19', '19', '19', 19, 19);
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (13, '19', '19');
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (12, NULL, '19');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (12, 10, '19');
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (13, 11, '19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.type AS TYPE, LHS.n AS n FROM (SELECT TYPE, COUNT(*) AS n FROM artwork GROUP BY TYPE) AS LHS INNER JOIN (SELECT TYPE, MAX(n) OVER () AS n FROM (SELECT TYPE, COUNT(*) AS n FROM artwork GROUP BY TYPE)) AS RHS ON (LHS.type = RHS.type AND LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
('19',)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('19',)
*/