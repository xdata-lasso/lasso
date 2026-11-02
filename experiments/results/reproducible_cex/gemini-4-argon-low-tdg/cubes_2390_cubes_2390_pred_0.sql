-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for Height (5000.0) and Prominence (1000.0), as well as AND vs OR logic.
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'ExactHeight_ValidProm', 5000.0, 999.9, 'Andes', 'Peru');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'BelowHeight_ValidProm', 4999.9, 1000.1, 'Alps', 'France');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'AboveHeight_ExactProm', 5000.1, 1000.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'ExactHeight_ExactProm', 5000.0, 1000.0, 'Rockies', 'USA');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (5, 'AboveHeight_BelowProm', 6000.0, 500.0, 'Karakoram', 'Pakistan');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (6, 'AboveHeight_AboveProm', 6000.0, 1500.0, 'Pamir', 'Tajikistan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM mountain WHERE (height >= 5000.0 AND prominence <> 1000.0) ORDER BY name, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('AboveHeight_AboveProm',)
('AboveHeight_BelowProm',)
('ExactHeight_ValidProm',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE Height > 5000 OR Prominence > 1000;

/*
Prediction Result:
('BelowHeight_ValidProm',)
('AboveHeight_ExactProm',)
('AboveHeight_BelowProm',)
('AboveHeight_AboveProm',)
*/