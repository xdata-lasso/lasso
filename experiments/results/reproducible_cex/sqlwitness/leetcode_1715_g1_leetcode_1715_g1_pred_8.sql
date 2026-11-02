-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (1, 1, 0), (-1, NULL, 1), (NULL, 0, 1), (0, 0, 0), (2, NULL, 1), (3, 0, 1), (4, NULL, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (3, 0, 0, 0), (4, NULL, 1, 0), (1, -1, 1, 1), (NULL, 1, 0, NULL), (4, 2, 1, NULL), (3, 3, 1, NULL), (4, 4, NULL, NULL), (0, 5, NULL, NULL), (0, 6, NULL, 0), (1, 7, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(6, 3)
*/

-- Prediction Query
SELECT SUM(BOXES.APPLE_COUNT + COALESCE(CHESTS.APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(BOXES.ORANGE_COUNT + COALESCE(CHESTS.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM BOXES LEFT JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID;

/*
Prediction Result:
(5, 2)
*/