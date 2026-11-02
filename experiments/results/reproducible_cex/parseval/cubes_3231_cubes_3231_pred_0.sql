-- Schema DDL
CREATE TABLE "mission" ("Mission_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Code" TEXT, "Launched_Year" INTEGER, "Location" TEXT, "Speed_knots" INTEGER, "Fate" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "ship" ("Ship_ID"));

CREATE TABLE "ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Nationality" TEXT, "Tonnage" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (1, 'shi_ca9c09', '5k5swwqcgs', 'C', 247012447);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (-2147483647, 'shi_ca9c09', '8c4pgu7vfe', 'G', -1633151678);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (2, 'a2y', 'uzhs', 'United Kingdom', 700293388);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (3, '5k5swwqcgs', '9n8', 'United States', 1610062532);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (4, '5k5swwqcgs', '9n8', NULL, 1610062532);

INSERT INTO "ship" ("ship_id", "name", "type", "nationality", "tonnage") VALUES (5, 'pgu7vfe4', 'hria2ypuzhs', NULL, 700293388);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "ship" WHERE ("nationality" <> 'United States' OR "nationality" <> 'United Kingdom') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('5k5swwqcgs',)
('a2y',)
('shi_ca9c09',)
('shi_ca9c09',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality = 'United States' OR Nationality = 'United Kingdom';

/*
Prediction Result:
('a2y',)
('5k5swwqcgs',)
*/