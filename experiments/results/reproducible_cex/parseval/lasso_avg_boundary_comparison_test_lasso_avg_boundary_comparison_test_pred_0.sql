-- Schema DDL
CREATE TABLE "Scores" ("id" INTEGER PRIMARY KEY, "score" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: scores --
INSERT INTO "scores" ("id", "score") VALUES (-2147483648, NULL);

INSERT INTO "scores" ("id", "score") VALUES (-2147483647, NULL);

INSERT INTO "scores" ("id", "score") VALUES (1, 582.588439);

INSERT INTO "scores" ("id", "score") VALUES (-2147483645, NULL);

INSERT INTO "scores" ("id", "score") VALUES (-2147483644, NULL);
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