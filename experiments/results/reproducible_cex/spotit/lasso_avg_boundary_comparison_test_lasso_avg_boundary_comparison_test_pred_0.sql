-- Schema DDL
CREATE TABLE "SCORES" (
    "ID" INT,
    "SCORE" FLOAT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SCORES VALUES (1, 0);
INSERT INTO SCORES VALUES (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Scores WHERE score >= (SELECT AVG(score) FROM Scores);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT id FROM Scores WHERE score > (SELECT AVG(score) FROM Scores);

/*
Prediction Result:
*/