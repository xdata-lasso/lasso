-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1083, 1084, 1085);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1083, 1086, NULL, 1085);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1083, 1087, NULL, 1089);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(2168, 4344)
*/

-- Prediction Query
SELECT X + T1.Z AS APPLE_COUNT, Y + T1.V AS ORANGE_COUNT FROM (SELECT COALESCE(SUM(C.APPLE_COUNT), 0) AS Z, COALESCE(SUM(C.ORANGE_COUNT), 0) AS V FROM CHESTS AS C LEFT JOIN BOXES AS B USING (CHEST_ID) WHERE NOT BOX_ID IS NULL) AS T1 CROSS JOIN (SELECT SUM(APPLE_COUNT) AS X, SUM(ORANGE_COUNT) AS Y FROM BOXES) AS T2;

/*
Prediction Result:
(None, 4344)
*/