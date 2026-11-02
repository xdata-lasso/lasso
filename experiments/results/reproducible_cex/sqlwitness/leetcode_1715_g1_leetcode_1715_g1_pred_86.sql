-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 1, NULL), (NULL, 1, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (-1, 1, 1, NULL), (-1, 0, NULL, NULL), (NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(3, 1)
*/

-- Prediction Query
SELECT SUM(CASE WHEN NOT T1.CHEST_ID IS NULL THEN T1.APPLE_COUNT + COALESCE(T2.APPLE_COUNT, 0) ELSE T1.APPLE_COUNT END) AS APPLE_COUNT, SUM(CASE WHEN NOT T1.CHEST_ID IS NULL THEN T1.ORANGE_COUNT + COALESCE(T2.ORANGE_COUNT, 0) ELSE T1.ORANGE_COUNT END) AS ORANGE_COUNT FROM BOXES AS T1 LEFT JOIN CHESTS AS T2 ON T1.CHEST_ID = T2.CHEST_ID;

/*
Prediction Result:
(2, 1)
*/