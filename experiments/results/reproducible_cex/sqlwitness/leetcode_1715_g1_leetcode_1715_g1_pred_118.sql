-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (0, NULL, NULL), (1, 0, 0), (-1, NULL, 0), (NULL, 1, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (0, -1, NULL, NULL), (0, 1, 0, 1), (NULL, NULL, 0, 0), (-1, 0, NULL, 1), (0, 2, NULL, NULL), (-1, 3, 1, 0), (0, 4, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(2, 2)
*/

-- Prediction Query
SELECT SUM(B.APPLE_COUNT) + (SELECT CASE WHEN B1.CHEST_ID IS NULL THEN 0 ELSE SUM(C.APPLE_COUNT) END FROM CHESTS AS C JOIN BOXES AS B1 ON B1.CHEST_ID = C.CHEST_ID) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) + (SELECT CASE WHEN B2.CHEST_ID IS NULL THEN 0 ELSE SUM(C1.ORANGE_COUNT) END FROM CHESTS AS C1 JOIN BOXES AS B2 ON B2.CHEST_ID = C1.CHEST_ID) AS ORANGE_COUNT FROM BOXES AS B;

/*
Prediction Result:
(None, 2)
*/