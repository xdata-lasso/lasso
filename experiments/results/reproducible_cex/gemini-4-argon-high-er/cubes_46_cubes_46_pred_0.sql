-- Schema DDL
CREATE TABLE "i025" ("Id" INTEGER, "Value" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i025 (Id, Value) VALUES (4, 'd');
INSERT INTO i025 (Id, Value) VALUES (3, 'c');
INSERT INTO i025 (Id, Value) VALUES (2, 'b');
INSERT INTO i025 (Id, Value) VALUES (1, 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, value FROM (SELECT id, value, ROW_NUMBER() OVER () AS row_number_ FROM i025) WHERE (row_number_ >= 3 AND row_number_ < 5) ORDER BY id, value NULLS LAST;

/*
Gold Result:
(1, 'a')
(2, 'b')
*/

-- Prediction Query
WITH NumberedMyTable AS (SELECT Id, Value, ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber FROM i025) SELECT Id, Value FROM NumberedMyTable WHERE RowNumber BETWEEN 3 AND 4;

/*
Prediction Result:
(3, 'c')
(4, 'd')
*/