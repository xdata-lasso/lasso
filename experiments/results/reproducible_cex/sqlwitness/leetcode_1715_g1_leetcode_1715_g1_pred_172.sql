-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (0, NULL, 0), (NULL, 0, 0), (1, NULL, 0), (-1, 0, 0), (2, NULL, 1), (3, 1, 1), (4, 0, 0), (5, NULL, 1), (6, 1, 0), (7, 1, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (2, NULL, 1, 0), (2, 0, NULL, 1), (0, 1, NULL, 0), (2, -1, 1, NULL), (2, 2, 1, 1), (7, 3, 0, 1), (1, 4, NULL, 1), (6, 5, 1, NULL), (5, 6, 0, NULL), (NULL, 7, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(6, 9)
*/

-- Prediction Query
SELECT SUM(B.APPLE_COUNT + COALESCE(CH.APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(B.ORANGE_COUNT + COALESCE(CH.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS CH ON B.CHEST_ID = CH.CHEST_ID;

/*
Prediction Result:
(6, 7)
*/