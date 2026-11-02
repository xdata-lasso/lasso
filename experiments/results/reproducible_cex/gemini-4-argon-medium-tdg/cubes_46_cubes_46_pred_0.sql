-- Schema DDL
CREATE TABLE "i025" ("Id" INTEGER, "Value" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i025 (Id, Value) VALUES (10, 'Z');
INSERT INTO i025 (Id, Value) VALUES (9, 'Y');
INSERT INTO i025 (Id, Value) VALUES (5, NULL);
INSERT INTO i025 (Id, Value) VALUES (5, 'A');
INSERT INTO i025 (Id, Value) VALUES (1, 'B');
INSERT INTO i025 (Id, Value) VALUES (2, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, value FROM (SELECT id, value, ROW_NUMBER() OVER () AS row_number_ FROM i025) WHERE (row_number_ >= 3 AND row_number_ < 5) ORDER BY id, value NULLS LAST;

/*
Gold Result:
(5, 'A')
(5, None)
*/

-- Prediction Query
WITH NumberedMyTable AS (SELECT Id, Value, ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber FROM i025) SELECT Id, Value FROM NumberedMyTable WHERE RowNumber BETWEEN 3 AND 4;

/*
Prediction Result:
(5, None)
(5, 'A')
*/