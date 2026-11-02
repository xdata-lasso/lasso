-- Schema DDL
CREATE TABLE "Scores" ("id" INTEGER PRIMARY KEY, "score" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO scores (id, score) VALUES (0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Scores WHERE score >= (SELECT AVG(score) FROM Scores);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT id FROM Scores WHERE score > (SELECT AVG(score) FROM Scores);

/*
Prediction Result:
*/