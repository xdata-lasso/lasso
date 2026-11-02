-- Schema DDL
CREATE TABLE "Scores" ("id" INTEGER PRIMARY KEY, "score" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "scores" ("id", "score") VALUES (1001, 1007.5);
INSERT INTO "scores" ("id", "score") VALUES (1002, 1009.5);
INSERT INTO "scores" ("id", "score") VALUES (1003, 1011.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Scores WHERE score >= (SELECT AVG(score) FROM Scores);

/*
Gold Result:
(1002,)
(1003,)
*/

-- Prediction Query
SELECT id FROM Scores WHERE score > (SELECT AVG(score) FROM Scores);

/*
Prediction Result:
(1003,)
*/