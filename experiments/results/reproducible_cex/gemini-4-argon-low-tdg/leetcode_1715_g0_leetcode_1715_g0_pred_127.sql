-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests boundary values (0 counts) and NULL counts inside Boxes table.
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 0, 10);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 20, 0);
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES (1, 1, 0, 0);
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES (2, 2, NULL, 5);
INSERT INTO Boxes (box_id, chest_id, apple_count, orange_count) VALUES (3, 1, 8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(8, 15)
*/

-- Prediction Query
WITH A AS (SELECT BOX_ID, B.CHEST_ID, C.APPLE_COUNT, C.ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID UNION ALL SELECT * FROM BOXES) SELECT SUM(COALESCE(APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(COALESCE(ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM A;

/*
Prediction Result:
(28, 25)
*/