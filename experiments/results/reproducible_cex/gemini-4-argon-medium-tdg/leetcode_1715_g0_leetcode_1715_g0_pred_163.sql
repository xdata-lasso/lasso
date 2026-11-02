-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 5);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 7, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 2, 3);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (2, 2, 11, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(20, 21)
*/

-- Prediction Query
WITH X AS (SELECT APP, ORA FROM (SELECT B.BOX_ID, SUM(B.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(C.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) AS APP, SUM(C.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(B.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID, B.CHEST_ID) AS ORA FROM BOXES AS B JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) AS K UNION ALL SELECT APPLE_COUNT AS APP, ORANGE_COUNT AS ORA FROM BOXES WHERE CASE WHEN CHEST_ID IN (SELECT CHEST_ID FROM (SELECT B.BOX_ID, SUM(B.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(C.APPLE_COUNT) OVER (PARTITION BY B.BOX_ID) AS APP, SUM(C.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID) + SUM(B.ORANGE_COUNT) OVER (PARTITION BY B.BOX_ID) AS ORA FROM BOXES AS B JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) AS J) THEN 0 ELSE 1 END) SELECT SUM(APP) AS APPLE_COUNT, SUM(ORA) AS ORANGE_COUNT FROM X;

/*
Prediction Result:
(18, 8)
*/