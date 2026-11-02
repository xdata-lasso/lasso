-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 10, 10);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, NULL, 5, 5);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, NULL, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(30, 30)
*/

-- Prediction Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT B.BOX_ID, B.APPLE_COUNT + (CASE WHEN NOT C.APPLE_COUNT IS NULL THEN C.APPLE_COUNT ELSE 0 END) AS APPLE_COUNT, B.ORANGE_COUNT + (CASE WHEN NOT C.ORANGE_COUNT IS NULL THEN C.ORANGE_COUNT ELSE 0 END) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C USING (CHEST_ID) GROUP BY B.BOX_ID) AS EXTR;

/*
Prediction Result:
(15, 15)
*/