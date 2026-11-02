-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 10, 10);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, NULL, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(15, 15)
*/

-- Prediction Query
SELECT X + T1.Z AS APPLE_COUNT, Y + T1.V AS ORANGE_COUNT FROM (SELECT COALESCE(SUM(C.APPLE_COUNT), 0) AS Z, COALESCE(SUM(C.ORANGE_COUNT), 0) AS V FROM CHESTS AS C LEFT JOIN BOXES AS B USING (CHEST_ID) WHERE NOT BOX_ID IS NULL) AS T1 CROSS JOIN (SELECT SUM(APPLE_COUNT) AS X, SUM(ORANGE_COUNT) AS Y FROM BOXES) AS T2;

/*
Prediction Result:
(5, 5)
*/