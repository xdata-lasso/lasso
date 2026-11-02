-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (0, 1, 1), (NULL, 0, 0), (1, 1, 1), (2, NULL, 0), (3, 1, 1), (4, NULL, 0), (5, 0, 1), (6, 1, NULL), (7, 1, 0), (8, NULL, 1), (9, NULL, 1), (10, 1, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (6, 0, 0, NULL), (9, NULL, 1, 1), (10, 1, NULL, 1), (1, 2, 0, NULL), (10, 3, NULL, NULL), (10, 4, 0, 0), (8, 5, 1, 0), (6, 6, 0, NULL), (5, 7, NULL, NULL), (2, 8, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(8, 6)
*/

-- Prediction Query
SELECT SUM(CASE WHEN NOT B.CHEST_ID IS NULL THEN B.APPLE_COUNT + A.APPLE_COUNT ELSE B.APPLE_COUNT END) AS APPLE_COUNT, SUM(CASE WHEN NOT B.CHEST_ID IS NULL THEN B.ORANGE_COUNT + A.ORANGE_COUNT ELSE B.ORANGE_COUNT END) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS A ON B.CHEST_ID = A.CHEST_ID;

/*
Prediction Result:
(4, 4)
*/