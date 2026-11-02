-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 10, 20);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, NULL, 5);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 2, 6, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, 3, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(18, 28)
*/

-- Prediction Query
SELECT IIF((AC1 + AC2) IS NULL, AC2, (AC1 + AC2)) AS APPLE_COUNT, IIF((OC1 + OC2) IS NULL, OC2, (OC1 + OC2)) AS ORANGE_COUNT FROM (SELECT SUM(C.APPLE_COUNT) AS AC1, SUM(C.ORANGE_COUNT) AS OC1, SUM(B.APPLE_COUNT) AS AC2, SUM(B.ORANGE_COUNT) AS OC2 FROM BOXES AS B LEFT JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) AS T;

/*
Prediction Result:
(28, 48)
*/