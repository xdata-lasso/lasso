-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 5, 5);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(5, 5)
*/

-- Prediction Query
SELECT SUM(TOTAL_APPLES) AS APPLE_COUNT, SUM(TOTAL_ORANGES) AS ORANGE_COUNT FROM (SELECT B.APPLE_COUNT + COALESCE(C.C_APPLE_COUNT, 0) AS TOTAL_APPLES, B.ORANGE_COUNT + COALESCE(C.C_ORANGE_COUNT, 0) AS TOTAL_ORANGES FROM BOXES AS B LEFT JOIN (SELECT CHEST_ID, APPLE_COUNT AS C_APPLE_COUNT, ORANGE_COUNT AS C_ORANGE_COUNT FROM CHESTS) AS C ON B.CHEST_ID = C.CHEST_ID) AS T;

/*
Prediction Result:
(None, None)
*/