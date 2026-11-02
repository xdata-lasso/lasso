-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (19, 1, 0);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (18, 0, 1);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, 17, NULL, 8136);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (19, NULL, NULL, 7070);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(1, 15206)
*/

-- Prediction Query
WITH COLUM_WISE_COUNT AS (SELECT (BOXES.APPLE_COUNT + CHESTS.APPLE_COUNT) AS APPLE_COUNT, (BOXES.ORANGE_COUNT + CHESTS.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES INNER JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID UNION ALL SELECT APPLE_COUNT, ORANGE_COUNT FROM BOXES WHERE CHEST_ID IS NULL) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM COLUM_WISE_COUNT;

/*
Prediction Result:
(None, 15206)
*/