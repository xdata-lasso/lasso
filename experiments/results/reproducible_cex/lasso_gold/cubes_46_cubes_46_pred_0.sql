-- Schema DDL
CREATE TABLE "i025" ("Id" INTEGER, "Value" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i025" ("id", "value") VALUES (1004, 'site');
INSERT INTO "i025" ("id", "value") VALUES (1007.0, 'face');
INSERT INTO "i025" ("id", "value") VALUES (1010.0, 'election');
INSERT INTO "i025" ("id", "value") VALUES (1004, 'site');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, value FROM (SELECT id, value, ROW_NUMBER() OVER () AS row_number_ FROM i025) WHERE (row_number_ >= 3 AND row_number_ < 5) ORDER BY id, value NULLS LAST;

/*
Gold Result:
(1004, 'site')
(1010, 'election')
*/

-- Prediction Query
WITH NumberedMyTable AS (SELECT Id, Value, ROW_NUMBER() OVER (ORDER BY Id) AS RowNumber FROM i025) SELECT Id, Value FROM NumberedMyTable WHERE RowNumber BETWEEN 3 AND 4;

/*
Prediction Result:
(1007, 'face')
(1010, 'election')
*/