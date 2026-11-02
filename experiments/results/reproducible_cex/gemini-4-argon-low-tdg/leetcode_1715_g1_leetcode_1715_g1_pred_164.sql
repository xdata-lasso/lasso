-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests handling of NULL values inside apple_count and orange_count columns across both tables,
-- as well as 0 boundary values and NULL chest_id in Chests.
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 10);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 20, NULL);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (NULL, 100, 100);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 5, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (2, 2, NULL, 15);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 3, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(25, 35)
*/

-- Prediction Query
WITH X AS (SELECT APP, ORA FROM (SELECT B.BOX_ID, SUM(B.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(C.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) AS APP, SUM(C.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(B.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID, B.CHEST_ID) AS ORA FROM BOXES AS B JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) AS K UNION ALL SELECT APPLE_COUNT AS APP, ORANGE_COUNT AS ORA FROM BOXES WHERE CASE WHEN CHEST_ID IN (SELECT CHEST_ID FROM (SELECT B.BOX_ID, SUM(B.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(C.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) AS APP, SUM(C.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(B.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID) AS ORA FROM BOXES AS B JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) AS J) THEN 0 ELSE 1 END) SELECT SUM(APP) AS APPLE_COUNT, SUM(ORA) AS ORANGE_COUNT FROM X;

/*
Prediction Result:
(None, 10)
*/