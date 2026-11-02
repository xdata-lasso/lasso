-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (16, 1, 854);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (15, NULL, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (15, 14, 1, 0);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (16, 13, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(1, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT SUM(B.APPLE_COUNT) AS NUM_APP1, SUM(COALESCE(C.APPLE_COUNT, 0)) AS NUM_APP2, SUM(B.ORANGE_COUNT) AS NUM_ORG1, SUM(COALESCE(C.ORANGE_COUNT, 0)) AS NUM_ORG2 FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID) SELECT (NUM_APP1 + NUM_APP2) AS APPLE_COUNT, (NUM_ORG1 + NUM_ORG2) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(2, 854)
*/