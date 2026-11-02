-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: chests --
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 1, 1);

INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (2, 1, 1);

INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (5, 1644814318, 1465859724);

-- Inserting into table: boxes --
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483648, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 1, 809183447, 89267185);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483646, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483645, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483644, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483643, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483642, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 2, 44952191, 1151980946);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 3, 1620389964, 546571701);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483639, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483638, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483637, 0, 0);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483636, NULL, 1);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483635, NULL, NULL);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, NULL, 1155439218, 1313172851);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483634, NULL, NULL);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483633, 1, NULL);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483632, NULL, 1);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483631, 1, NULL);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483630, NULL, 1);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (5, -2147483629, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(15143665063, 13362010768)
*/

-- Prediction Query
WITH AA AS (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES), BB AS (SELECT A.APPLE_COUNT * COUNT(B.BOX_ID) AS APPLE_COUNT, A.ORANGE_COUNT * COUNT(B.BOX_ID) AS ORANGE_COUNT FROM CHESTS AS A JOIN BOXES AS B ON A.CHEST_ID = B.CHEST_ID GROUP BY A.CHEST_ID) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT * FROM AA UNION ALL SELECT * FROM BB) AS CC;

/*
Prediction Result:
(15143665062, 13362010767)
*/