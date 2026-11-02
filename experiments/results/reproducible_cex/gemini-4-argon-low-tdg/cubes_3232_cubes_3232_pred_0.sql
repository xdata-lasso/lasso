-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (1, 'Enterprise', 'Carrier', 'United States', 80000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (2, 'Victory', 'Battleship', 'United Kingdom', 3500);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (3, 'Yamato', 'Battleship', 'Japan', 72000);
INSERT INTO ship (Ship_ID, Name, Type, Nationality, Tonnage) VALUES (4, 'Bismarck', 'Battleship', 'Germany', 50000);
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (101, 1, 'M-US1', 1942, 'Pacific', 32, 'Survived');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (102, 2, 'M-UK1', 1805, 'Trafalgar', 8, 'Survived');
INSERT INTO mission (Mission_ID, Ship_ID, Code, Launched_Year, Location, Speed_knots, Fate) VALUES (103, 2, 'M-UK2', 1806, 'Portsmouth', 0, 'Museum');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Bismarck',)
('Victory',)
('Yamato',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality <> 'United States';

/*
Prediction Result:
('Victory',)
('Yamato',)
('Bismarck',)
*/