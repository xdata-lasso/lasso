-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 10, 10);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, NULL, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 2, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(15, 15)
*/

-- Prediction Query
SELECT SUM(B.APPLE_COUNT) + (SELECT CASE WHEN B1.CHEST_ID IS NULL THEN 0 ELSE SUM(C.APPLE_COUNT) END FROM CHESTS AS C JOIN BOXES AS B1 ON B1.CHEST_ID = C.CHEST_ID) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) + (SELECT CASE WHEN B2.CHEST_ID IS NULL THEN 0 ELSE SUM(C1.ORANGE_COUNT) END FROM CHESTS AS C1 JOIN BOXES AS B2 ON B2.CHEST_ID = C1.CHEST_ID) AS ORANGE_COUNT FROM BOXES AS B;

/*
Prediction Result:
(25, 25)
*/