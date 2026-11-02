-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT (SUM(COALESCE(BOXES.APPLE_COUNT, 0)) + SUM(COALESCE(CHESTS.APPLE_COUNT, 0))) AS APPLE_COUNT, (SUM(COALESCE(BOXES.ORANGE_COUNT, 0)) + SUM(COALESCE(CHESTS.ORANGE_COUNT, 0))) AS ORANGE_COUNT FROM BOXES LEFT JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID;

/*
Prediction Result:
(0, 0)
*/