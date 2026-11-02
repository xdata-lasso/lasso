-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (24, 0, 2001);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (26, 1, 2001);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (24, 23, 5449, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (26, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(5449, None)
*/

-- Prediction Query
WITH T AS (SELECT BOXES.APPLE_COUNT, BOXES.ORANGE_COUNT, CHESTS.APPLE_COUNT AS CHEST_A, CHESTS.ORANGE_COUNT AS CHEST_O FROM BOXES LEFT JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID) SELECT SUM(APPLE_COUNT) + COALESCE(SUM(CHEST_A), 0) AS APPLE_COUNT, SUM(ORANGE_COUNT) + COALESCE(SUM(CHEST_O), 0) AS ORANGE_COUNT FROM T;

/*
Prediction Result:
(5450, None)
*/