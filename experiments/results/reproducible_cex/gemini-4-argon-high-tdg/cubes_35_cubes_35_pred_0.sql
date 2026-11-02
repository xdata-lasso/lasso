-- Schema DDL
CREATE TABLE "i003" ("c" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i003 (c) VALUES ('apple');
INSERT INTO i003 (c) VALUES ('banana');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT GROUP_CONCAT("c", ', ') AS concatc FROM i003 ORDER BY concatc;

/*
Gold Result:
('apple, banana',)
*/

-- Prediction Query
SELECT c FROM i003 AS t;

/*
Prediction Result:
('apple',)
('banana',)
*/