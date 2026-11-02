-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(5, 5)
*/

-- Prediction Query
WITH CTE AS (SELECT BOX_ID, CASE WHEN B.CHEST_ID = C.CHEST_ID THEN B.APPLE_COUNT + C.APPLE_COUNT ELSE B.APPLE_COUNT END AS APPLE, CASE WHEN B.CHEST_ID = C.CHEST_ID THEN B.ORANGE_COUNT + C.ORANGE_COUNT ELSE B.ORANGE_COUNT END AS ORANGE FROM BOXES AS B LEFT JOIN CHESTS AS C USING (CHEST_ID)) SELECT SUM(APPLE) AS APPLE_COUNT, SUM(ORANGE) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(None, None)
*/