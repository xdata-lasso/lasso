-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 0, 0), (1, 1, 0), (0, 1, 1), (NULL, 1, NULL), (2, NULL, NULL), (3, NULL, 0), (4, NULL, NULL), (5, 0, 1), (6, 1, 0), (7, NULL, 1), (8, 0, NULL), (9, NULL, NULL), (10, 0, NULL), (11, 1, NULL), (12, NULL, 1), (13, NULL, 0), (14, 0, 0), (15, 0, 0), (16, 1, NULL), (17, 1, NULL), (18, 0, 1), (19, NULL, NULL), (20, NULL, NULL), (21, 1, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (8, 1, 1, 0), (-1, 0, NULL, NULL), (5, -1, 1, NULL), (5, NULL, 0, 0), (18, 2, 1, 1), (13, 3, 1, 1), (7, 4, 1, NULL), (8, 5, 1, 0), (13, 6, 1, 0), (19, 7, NULL, NULL), (NULL, 8, 1, NULL), (19, 9, NULL, 0), (21, 10, NULL, 1), (12, 11, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(10, 8)
*/

-- Prediction Query
SELECT X + T1.Z AS APPLE_COUNT, Y + T1.V AS ORANGE_COUNT FROM (SELECT COALESCE(SUM(C.APPLE_COUNT), 0) AS Z, COALESCE(SUM(C.ORANGE_COUNT), 0) AS V FROM CHESTS AS C LEFT JOIN BOXES AS B USING (CHEST_ID) WHERE NOT BOX_ID IS NULL) AS T1 CROSS JOIN (SELECT SUM(APPLE_COUNT) AS X, SUM(ORANGE_COUNT) AS Y FROM BOXES) AS T2;

/*
Prediction Result:
(10, 7)
*/