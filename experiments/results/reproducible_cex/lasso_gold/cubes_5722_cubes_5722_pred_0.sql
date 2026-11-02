-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1006, 'Allen Robinson', 'mouth', 'Netherlands', 1007);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1008, 'Cristian Santos', 'offer', 'Italy', 1009);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1010, 'Cristian Santos', 'offer', 'Italy', 1009);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1011, NULL, 'according', 'Senegal', 1012);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1013, NULL, 'clearly', 'Cuba', 1014);
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1015, NULL, 'clearly', 'Cuba', 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT LHS.n AS n, RHS.type AS TYPE FROM (SELECT MAX(n) AS n FROM (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE)) AS LHS LEFT JOIN (SELECT TYPE, COUNT(*) AS n FROM ship GROUP BY TYPE) AS RHS ON (LHS.n = RHS.n)) ORDER BY TYPE;

/*
Gold Result:
('clearly',)
('offer',)
*/

-- Prediction Query
SELECT TYPE FROM ship GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('clearly',)
*/