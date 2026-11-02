-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 1, 1), (1, 1, 0), (0, NULL, 0), (NULL, 0, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (-1, -1, NULL, 1), (-1, NULL, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(2, 3)
*/

-- Prediction Query
WITH AA AS (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES), BB AS (SELECT A.APPLE_COUNT * COUNT(B.BOX_ID) AS APPLE_COUNT, A.ORANGE_COUNT * COUNT(B.BOX_ID) AS ORANGE_COUNT FROM CHESTS AS A JOIN BOXES AS B ON A.CHEST_ID = B.CHEST_ID GROUP BY A.CHEST_ID) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT * FROM AA UNION ALL SELECT * FROM BB) AS CC;

/*
Prediction Result:
(2, 2)
*/