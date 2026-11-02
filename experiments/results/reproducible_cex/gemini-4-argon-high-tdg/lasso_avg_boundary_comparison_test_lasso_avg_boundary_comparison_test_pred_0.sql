-- Schema DDL
CREATE TABLE "Scores" ("id" INTEGER PRIMARY KEY, "score" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scores (id, score) VALUES (101, 50.0);
INSERT INTO Scores (id, score) VALUES (102, 20.0);
INSERT INTO Scores (id, score) VALUES (103, 10.0);
INSERT INTO Scores (id, score) VALUES (104, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Scores WHERE score >= (SELECT AVG(score) FROM Scores);

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT id FROM Scores WHERE score > (SELECT AVG(score) FROM Scores);

/*
Prediction Result:
(101,)
*/