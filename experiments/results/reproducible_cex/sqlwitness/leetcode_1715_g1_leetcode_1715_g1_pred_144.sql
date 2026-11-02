-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (1, 1, 1), (NULL, NULL, 0), (0, 1, 0), (2, 1, 0), (3, 1, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (0, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(2, 0)
*/

-- Prediction Query
SELECT SUM(CASE WHEN NOT TB1.CHEST_ID IS NULL THEN (TB1.APPLE_COUNT + TB2.APPLE_COUNT) ELSE TB1.APPLE_COUNT END) AS APPLE_COUNT, SUM(CASE WHEN NOT TB1.CHEST_ID IS NULL THEN (TB1.ORANGE_COUNT + TB2.ORANGE_COUNT) ELSE TB1.ORANGE_COUNT END) AS ORANGE_COUNT FROM BOXES AS TB1 LEFT JOIN CHESTS AS TB2 ON TB1.CHEST_ID = TB2.CHEST_ID;

/*
Prediction Result:
(2, None)
*/