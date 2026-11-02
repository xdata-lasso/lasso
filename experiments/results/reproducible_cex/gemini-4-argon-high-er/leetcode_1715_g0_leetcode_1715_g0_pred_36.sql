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
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
WITH T1 AS (SELECT A.*, B.APPLE_COUNT AS APPLE2, B.ORANGE_COUNT AS ORANGE2 FROM BOXES AS A LEFT JOIN CHESTS AS B ON A.CHEST_ID = B.CHEST_ID), T2 AS (SELECT BOX_ID, CHEST_ID, COALESCE(APPLE_COUNT, 0) + COALESCE(APPLE2, 0) AS APPLE, COALESCE(ORANGE_COUNT, 0) + COALESCE(ORANGE2, 0) AS ORANGE FROM T1) SELECT SUM(APPLE) AS APPLE_COUNT, SUM(ORANGE) AS ORANGE_COUNT FROM T2;

/*
Prediction Result:
(5, 5)
*/