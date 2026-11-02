-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, -1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(None, 0)
*/

-- Prediction Query
SELECT (COALESCE(BSUM.APPLE_COUNT, 0) + COALESCE(CSUM.APPLE_COUNT, 0)) AS APPLE_COUNT, (COALESCE(BSUM.ORANGE_COUNT, 0) + COALESCE(CSUM.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM (SELECT SUM(CHESTS.APPLE_COUNT) AS APPLE_COUNT, SUM(CHESTS.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES LEFT JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID) AS CSUM CROSS JOIN (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES) AS BSUM;

/*
Prediction Result:
(0, 0)
*/