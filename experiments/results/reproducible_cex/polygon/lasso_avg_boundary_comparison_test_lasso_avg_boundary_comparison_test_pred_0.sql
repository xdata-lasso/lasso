-- Schema DDL
CREATE TABLE "Scores" ("id" INTEGER PRIMARY KEY, "score" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scores" ("id", "score") VALUES (20, -899);
INSERT INTO "Scores" ("id", "score") VALUES (18, -900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Scores WHERE score >= (SELECT AVG(score) FROM Scores);

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT id FROM Scores WHERE score > (SELECT AVG(score) FROM Scores);

/*
Prediction Result:
(20,)
*/