-- Schema DDL
CREATE TABLE "i003" ("c" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i003" ("c") VALUES ('brother');
INSERT INTO "i003" ("c") VALUES (NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT GROUP_CONCAT("c", ', ') AS concatc FROM i003 ORDER BY concatc;

/*
Gold Result:
('brother',)
*/

-- Prediction Query
SELECT c FROM i003 AS t;

/*
Prediction Result:
('brother',)
(None,)
*/