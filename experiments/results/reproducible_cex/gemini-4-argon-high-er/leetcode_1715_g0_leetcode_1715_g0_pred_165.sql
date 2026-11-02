-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 10);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 5, 5);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, NULL, 2, 2);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(9, 19)
*/

-- Prediction Query
WITH CTE AS (SELECT BOX_ID, APPLE_COUNT, ORANGE_COUNT FROM BOXES WHERE CHEST_ID IS NULL UNION SELECT B.BOX_ID, B.APPLE_COUNT + C.APPLE_COUNT, B.ORANGE_COUNT + C.ORANGE_COUNT FROM BOXES AS B INNER JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(2, 17)
*/