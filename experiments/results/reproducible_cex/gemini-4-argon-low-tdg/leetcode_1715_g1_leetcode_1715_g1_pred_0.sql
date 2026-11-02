-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, 1-to-many join duplication (multiple boxes referencing the same chest),
-- boxes with NULL chest_id (should be included in first branch, excluded from second branch),
-- and chests with no referencing boxes (should be excluded completely).
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 10, 20);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 100, 200);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 10, 1, 2);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 20, 3, 4);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, 30, 5, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(29, 52)
*/

-- Prediction Query
SELECT * FROM (SELECT SUM(B.APPLE_COUNT) AS BA, SUM(B.ORANGE_COUNT) AS BO, SUM(COALESCE(C.APPLE_COUNT, 0)) AS CA, SUM(COALESCE(C.ORANGE_COUNT, 0)) AS CO FROM BOXES AS B LEFT OUTER JOIN CHESTS AS C ON (B.CHEST_ID = C.CHEST_ID)) AS T1;

/*
Prediction Result:
(9, 12, 20, 40)
*/