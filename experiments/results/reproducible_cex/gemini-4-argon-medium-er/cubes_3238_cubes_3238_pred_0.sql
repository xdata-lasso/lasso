-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (1, 'B_Ship', 'Cargo', 'USA', 1000);
INSERT INTO "ship" ("Ship_ID", "Name", "Type", "Nationality", "Tonnage") VALUES (2, 'A_Ship', 'Cargo', 'UK', 2000);
INSERT INTO "mission" ("Mission_ID", "Ship_ID", "Code", "Launched_Year", "Location", "Speed_knots", "Fate") VALUES (1, NULL, 'M1', 2020, 'Sea', 10, 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM mission AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name;

/*
Gold Result:
('A_Ship',)
('B_Ship',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE NOT Ship_ID IN (SELECT Ship_ID FROM mission);

/*
Prediction Result:
*/