-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, nationality, tonnage) VALUES (3, 'default2', NULL, NULL, NULL), (2, 'default2', NULL, NULL, 3), (1, 'default2', 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
*/