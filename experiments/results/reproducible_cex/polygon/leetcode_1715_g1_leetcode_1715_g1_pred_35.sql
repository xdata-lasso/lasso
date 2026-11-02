-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (39, 1, NULL);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (17, 0, 0);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, 16, 3699, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (39, 40, NULL, 3702);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(3700, 3702)
*/

-- Prediction Query
WITH CTE AS (SELECT B.BOX_ID, B.CHEST_ID, B.APPLE_COUNT + COALESCE(C.APPLE_COUNT, 0) AS APPLE_COUNT, B.ORANGE_COUNT + COALESCE(C.ORANGE_COUNT, 0) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID GROUP BY B.BOX_ID, B.CHEST_ID) SELECT SUM(CTE.APPLE_COUNT) AS APPLE_COUNT, SUM(CTE.ORANGE_COUNT) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(3699, 3702)
*/