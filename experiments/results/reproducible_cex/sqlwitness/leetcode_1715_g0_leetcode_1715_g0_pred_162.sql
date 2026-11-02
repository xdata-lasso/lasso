-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 0), (0, 0, NULL), (-1, 0, 1), (NULL, 0, 1), (2, NULL, NULL), (3, NULL, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, -1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT * FROM BOXES WHERE NOT CHEST_ID IS NULL), CTE1 AS (SELECT C1.BOX_ID, C1.APPLE_COUNT AS ACNT1, C1.ORANGE_COUNT AS OCNT1, C2.APPLE_COUNT AS ACNT2, C2.ORANGE_COUNT AS OCNT2 FROM CTE AS C1 JOIN CHESTS AS C2 ON C1.CHEST_ID = C2.CHEST_ID), CTE2 AS (SELECT BOX_ID, ACNT1 + ACNT2 AS APPLE_COUNT, OCNT1 + OCNT2 AS ORANGE_COUNT FROM CTE1) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT BOX_ID, APPLE_COUNT, ORANGE_COUNT FROM BOXES WHERE CHEST_ID IS NULL UNION ALL SELECT BOX_ID, APPLE_COUNT, ORANGE_COUNT FROM CTE2) AS A;

/*
Prediction Result:
(None, 1)
*/