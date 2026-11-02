-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'M1_ExactHeight_LessProm', 5000.0, 999.9, 'Andes', 'Peru');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'M2_ExactHeight_ExactProm', 5000.0, 1000.0, 'Andes', 'Peru');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'M3_ExactHeight_MoreProm', 5000.0, 1000.1, 'Andes', 'Peru');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (4, 'M4_LowHeight_LessProm', 4999.9, 999.9, 'Alps', 'France');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (5, 'M5_LowHeight_ExactProm', 4999.9, 1000.0, 'Alps', 'France');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (6, 'M6_LowHeight_MoreProm', 4999.9, 1000.1, 'Alps', 'France');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (7, 'M7_HighHeight_LessProm', 5000.1, 500.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (8, 'M8_HighHeight_ExactProm', 5000.1, 1000.0, 'Himalayas', 'Nepal');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (9, 'M9_HighHeight_MoreProm', 5000.1, 2000.0, 'Himalayas', 'Nepal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM mountain WHERE (height >= 5000.0 AND prominence <> 1000.0) ORDER BY name, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('M1_ExactHeight_LessProm',)
('M3_ExactHeight_MoreProm',)
('M7_HighHeight_LessProm',)
('M9_HighHeight_MoreProm',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE Height > 5000 OR Prominence > 1000;

/*
Prediction Result:
('M3_ExactHeight_MoreProm',)
('M6_LowHeight_MoreProm',)
('M7_HighHeight_LessProm',)
('M8_HighHeight_ExactProm',)
('M9_HighHeight_MoreProm',)
*/