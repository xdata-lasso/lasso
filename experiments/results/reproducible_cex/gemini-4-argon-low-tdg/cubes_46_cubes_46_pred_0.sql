-- Schema DDL
CREATE TABLE "i025" ("Id" INTEGER, "Value" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO i025 (Id, Value) VALUES (10, 'a');
INSERT INTO i025 (Id, Value) VALUES (20, 'b');
INSERT INTO i025 (Id, Value) VALUES (15, NULL);
INSERT INTO i025 (Id, Value) VALUES (15, 'c');
INSERT INTO i025 (Id, Value) VALUES (5, 'd');
INSERT INTO i025 (Id, Value) VALUES (25, 'e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, value FROM (SELECT id, value, ROW_NUMBER() OVER () AS row_number_ FROM i025) WHERE (row_number_ >= 3 AND row_number_ < 5) ORDER BY id, value NULLS LAST;

/*
Gold Result:
(15, 'c')
(15, None)
*/

-- Prediction Query
WITH NumberedMyTable AS (SELECT Id, Value, ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber FROM i025) SELECT Id, Value FROM NumberedMyTable WHERE RowNumber BETWEEN 3 AND 4;

/*
Prediction Result:
(15, None)
(15, 'c')
*/