-- Schema DDL
CREATE TABLE "i003" ("c" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i003" ("c") VALUES ('a');
INSERT INTO "i003" ("c") VALUES ('b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT GROUP_CONCAT("c", ', ') AS concatc FROM i003 ORDER BY concatc;

/*
Gold Result:
('a, b',)
*/

-- Prediction Query
SELECT c FROM i003 AS t;

/*
Prediction Result:
('a',)
('b',)
*/