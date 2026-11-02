-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1, 'Allison Hill', 'dog', 'Burundi', 1001);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1002, 'Megan Mcclain', 'begin', 'Burundi', 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT TYPE FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY TYPE;

/*
Gold Result:
('begin',)
('dog',)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('begin',)
*/