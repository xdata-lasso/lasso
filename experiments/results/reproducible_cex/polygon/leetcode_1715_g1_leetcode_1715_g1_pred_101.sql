-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (43, NULL, 6156);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (45, NULL, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (45, NULL, NULL, 6156);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (43, 44, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(None, 12312)
*/

-- Prediction Query
WITH CTE AS (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES UNION SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C JOIN BOXES AS B ON C.CHEST_ID = B.CHEST_ID WHERE NOT B.CHEST_ID IS NULL) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(None, 6156)
*/