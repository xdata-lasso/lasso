-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 0, 1), (0, 1, NULL), (1, NULL, 0), (NULL, 1, NULL), (2, 1, 1), (3, 1, 1), (4, 1, 0), (5, 1, NULL), (6, NULL, NULL), (7, 0, 0), (8, 1, 0), (9, 1, 1), (10, 1, 1), (11, 1, 0), (12, 0, 0), (13, 0, 0), (14, 1, 1), (15, 0, 0), (16, 0, 1), (17, NULL, NULL), (18, NULL, 1), (19, 0, NULL), (20, NULL, NULL), (21, 0, NULL), (22, NULL, NULL), (23, 0, 0), (24, 1, 0), (25, 1, 0), (26, 0, 1), (27, 1, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, -1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(None, 0)
*/

-- Prediction Query
SELECT SUM(COALESCE(C.APPLE_COUNT, 0)) + SUM(COALESCE(B.APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(COALESCE(C.ORANGE_COUNT, 0)) + SUM(COALESCE(B.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID;

/*
Prediction Result:
(0, 0)
*/