-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.n AS n, RHS.type AS TYPE FROM (SELECT MAX(n) AS n FROM (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE)) AS LHS LEFT JOIN (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE) AS RHS ON (LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
*/