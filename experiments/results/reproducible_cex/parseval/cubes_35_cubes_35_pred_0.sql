-- Schema DDL
CREATE TABLE "i003" ("c" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i003 --
INSERT INTO "i003" ("c") VALUES (NULL);

INSERT INTO "i003" ("c") VALUES ('i00_f3a6ce');

INSERT INTO "i003" ("c") VALUES ('i00_f3a6ce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT GROUP_CONCAT("c", ', ') AS concatc FROM i003 ORDER BY concatc;

/*
Gold Result:
('i00_f3a6ce, i00_f3a6ce',)
*/

-- Prediction Query
SELECT c FROM i003 AS t;

/*
Prediction Result:
(None,)
('i00_f3a6ce',)
('i00_f3a6ce',)
*/