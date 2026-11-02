-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("Ship_ID", "Name") VALUES (1, 'B');
INSERT INTO "ship" ("Ship_ID", "Name") VALUES (2, 'A');
INSERT INTO "mission" ("Mission_ID", "Ship_ID") VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM mission AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE NOT Ship_ID IN (SELECT Ship_ID FROM mission);

/*
Prediction Result:
*/