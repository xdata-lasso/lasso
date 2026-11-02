-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, 'evidence', NULL);
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, 'news', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
WITH V AS (SELECT V1.NAME AS NAME1, V1.VALUE AS VALUE1, V2.NAME AS NAME2, V2.VALUE AS VALUE2 FROM VARIABLES AS V1 CROSS JOIN VARIABLES AS V2) SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND V.VALUE1 > V.VALUE2 THEN 'true' WHEN OPERATOR = '<' AND V.VALUE1 < V.VALUE2 THEN 'true' WHEN OPERATOR = '=' AND V.VALUE1 = V.VALUE2 THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN V ON E.LEFT_OPERAND = V.NAME1 AND E.RIGHT_OPERAND = V.NAME2;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/