-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 5, 5);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(10, 10)
*/

-- Prediction Query
WITH A AS (SELECT B.*, C.APPLE_COUNT AS A, C.ORANGE_COUNT AS C FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID), T AS (SELECT SUM(COALESCE(APPLE_COUNT, 0)) AS AC, SUM(COALESCE(ORANGE_COUNT, 0)) AS OC FROM A UNION SELECT SUM(COALESCE(A, 0)), SUM(COALESCE(C, 0)) FROM A) SELECT SUM(AC) AS APPLE_COUNT, SUM(OC) AS ORANGE_COUNT FROM T;

/*
Prediction Result:
(5, 5)
*/